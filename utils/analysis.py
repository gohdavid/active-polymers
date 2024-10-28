from pathlib import Path
from act_pol.analysis.files import process_sim
import numpy as np
from scipy.stats import gaussian_kde, maxwell, norm
from matplotlib.lines import Line2D
import subprocess
np.random.seed(seed=42)

class Constants:
    """A class for constants."""
    kb = 80.10471204188482 # nm per kb
    
    # Define unitful length scale
    Lk = 35.36  # Kuhn length in nm

    # Get simulation parameters
    Lc = 250*kb
    N = round(Lc/Lk) + 1  # Number of beads
    b = 1
    Lp = b/2
    R = 250/Lk
    mid = (N-1)/2
    
    De = 0.02093842997871517*1e6 # Diffusivity of DNA nm^2/s

class Simulation(Constants):
    """A class to process simulation data."""

    def __init__(self, *, B, F, A, L, R, b=1, directory="simulations", unitful=False, subsample=False):
        self.path = Path(f"./{directory}/B{B:.3g}_F{F:.3g}_A{A:.3g}_L{L:.3g}_R{R:.3g}/")
        self.files = list(self.path.glob("tape*.csv"))
        
        self.Lep = round(L*self.kb/self.Lk)
        self.s1 = round(self.mid - self.Lep/2)  # Enhancer position
        self.s2 = round(self.mid + self.Lep/2)  # Promoter position
        self.Nep = self.s2-self.s1
        
        if unitful:
            conversion = self.Lk
            self.b = self.b*conversion
            self.Lep = self.Lep*conversion
            self.Lp = self.Lp*conversion
            self.R = self.R*conversion
        else:
            conversion = 1

        # Compute displacement
        numpyfile = self.path/"concatenated_results.npy"
        if (numpyfile).exists():
            self.displacement = np.squeeze(np.load(numpyfile))
        else:
            self.displacement = np.squeeze(
                np.vstack([
                    np.diff(process_sim(file)[0][:, [self.s1, self.s2], :], axis=1)
                    for file in self.files
                ])
                )
            np.save(numpyfile, self.displacement)
        # Convert length data to unitful quantities if unitful=True
        self.displacement = self.displacement*conversion
        
        if subsample:
            num_rows = self.displacement.shape[0]
            random_indices = np.random.choice(num_rows, size=subsample, replace=False)
            self.displacement = self.displacement[random_indices, :]


        # Generate Gaussian KDEs for displacement
        self.displacement_g = [
            gaussian_kde(self.displacement[:, i]) 
            for i in range(self.displacement.shape[1])
        ]

        # Compute 1D Gaussians of variance Nb^2/3
        gaussian_1D_prefactor = (3/(2*np.pi*self.Nep*self.b**2))**(1/2)
        self.gaussian_1D = lambda r: gaussian_1D_prefactor*np.exp(-3/(2*self.Nep*self.b**2)*r**2)
        self.gaussian_1D_rv = norm(scale=np.sqrt(self.Nep*self.b**2/3))
        
        # Compute distance and its Gaussian KDE
        # If unitful=True, there's no need to convert again since we use displacement data
        self.distance = np.linalg.norm(self.displacement, axis=1)
        self.distance_g = gaussian_kde(self.distance)
        
        # Compute maxwell distribution
        maxwell_prefactor = 4*np.pi*(3/(4*self.Lep*self.Lp)/np.pi)**(3/2)
        self.maxwell = lambda r: maxwell_prefactor*r**2*np.exp(-3/(4*self.Lep*self.Lp)*(r**2))
        self.maxwell_rv = maxwell(scale=np.sqrt(2*self.Lep*self.Lp/3))

def hist(ax,arr,density=True,fill=False,histtype='step',linewidth=1.5,**kwargs):
    """Plot a histogram with pre-defined kwargs."""
    ax.hist(arr,density=density,fill=fill,histtype=histtype,linewidth=linewidth,**kwargs)

def histlegend(ax,**kwargs):
    """Convert step legend handles to lines."""
    
    handles, labels = ax.get_legend_handles_labels()
    new_handles = [
        h if isinstance(h, Line2D) else Line2D([], [], c=h.get_edgecolor())
        for h in handles
    ]
    ax.legend(handles=new_handles, labels=labels,**kwargs)