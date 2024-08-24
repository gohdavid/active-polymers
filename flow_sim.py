import numpy as np
from act_pol.bdsim.bd import *
import pandas as pd
from pathlib import Path
from multiprocessing import Pool
from functools import partial
import time
import matplotlib.pyplot as plt
import sys
import os
from scipy.stats import mode
from fractions import Fraction

def recommended_dt(*, N, L, b, D):
    r"""
    Recommended "dt" for use with ``rouse*jit`` family of functions.
    Our srk1 scheme is accurate as long as :math:`\Delta t` is less than the
    transition time where the MSD goes from high k behavior (:math:`t^1`) to
    Rouse behavior (:math:`t^{1/2}`).  This is exactly the time required to
    diffuse a Kuhn length, so we just need to ensure that :math:`\Delta t <
    \frac{\hat{b}^2}{6\hat{D}}` in 3D. The "crossover" from fast-k to
    rouse-like behavior takes about one order of magnitude in time, and it was
    determined empirically that decreasing the time step beyond that point
    doesn't seem to make the MSD any more accurate.
    Note that it can be shown that *no* scheme can accurately reproduce the
    bead behavior using larger time s teps than the time required to diffuse a
    distance of one Kuhn length.
    Notes
    -----
    Recall (doi & edwards, eq 4.25) that the first mode's relaxation time is
    :math:`\tau_1 = \frac{\xi N^2}{k \pi^2 }` (see Doi & Edwards, Eq. 4.25),
    and the :math:`p`\th mode is :math:`\tau_p = \tau_1/p^2` (this is the
    exponential falloff rate of the :math:`p`\th mode's correlation function).
    The accuracy of these values was also used when empirically determining the
    recommended ``dt``.
    """
    Nhat = L/b
    L0 = L/(N-1)
    Dhat = D*N/Nhat
    bhat = np.sqrt(L0*b)
    return (1/10)*bhat**2/(6*Dhat)

def terminal_relaxation(*, N, L, b, D):
    """ Rouse time for the polymer."""
    Nhat = L/b
    return b**2 * Nhat**2 / (3 * np.pi**2 * D)

def main():
    if len(sys.argv) < 5:
        print(("Usage: python flow_sim.py <job_id> <velocity_prefactor> "
               "<friction> <diffusivity> <E-P tether length>"))
        sys.exit(1)
    
    i = 1  # Number of repeats

    # Free parameters
    B = float(sys.argv[2])  # Strength of condensate-to-promoter force
    enhancer_friction = float(sys.argv[3])  # Friction coefficient of enhancer
    enhancer_diffusivity = float(Fraction(sys.argv[4]))  # Diffusivity of enhancer
    Lep_kb = float(sys.argv[5])  # Enhancer-promoter separation in kb

    # Fixed parameters
    kb = 80.10471204188482 # nm per kb
    Lk = 35.36  # Kuhn length in nm
    Lc = 300*kb # 300 kb in nm
    N = round(Lc/Lk) + 1  # Number of beads
    L = round(Lc/Lk)  # Contour length in units of Kuhn length
    b = 1  # Kuhn length, sets the length scale to be ~ Lk value
    D = np.ones(N)  # Diffusion coefficients, sets the time scale to be ~ Lk^2 value
    xi = np.ones(N)  # Friction coefficients
    R = 250/Lk  # Radius of condensate in units of Kuhn length
    l = 4242.640687119285/Lk  # Diffusion length of RNA in units of Kuhn length
    Lep = round(Lep_kb*kb/Lk)  # Enhancer-promoter separation in units of Kuhn length
    mid = (N-1)/2  # Index to make enhancer and promoter symmetric about the polymer midpoint
    s1 = round(mid - Lep/2)  # Enhancer position
    s2 = round(mid + Lep/2)  # Promoter position
    lamb = 0
    Deq = 1

    # Rouse time step and time
    h = recommended_dt(N=N,L=L,b=b,D=mode(D)[0])  # Maximum dt
    tmax = 2 * terminal_relaxation(N=N,L=L,b=b,D=mode(D)[0])  # Twice the Rouse time for the polymer
    
    # Simulation details
    t_save = np.linspace(tmax/2,tmax,12)[1:-1]  # Save 10 points between Rouse times
    t_msd = np.logspace(-2, 5, 100)  # Time to save MSD
    msd_start_time = 0.0  # Time to start saving MSD
    
    # Implement free parameters
    D[s1] = enhancer_diffusivity  # Modify enhancer diffusivity
    xi[s1] = enhancer_friction  # Modify enhancer friction

    # Name of simulation file
    job_id = sys.argv[1]  # Get first script input
    filedir = Path(f"./simulations/B{B:.3g}_F{enhancer_friction:.3g}_D{enhancer_diffusivity:.3g}/")  # Simulation directory
    file = filedir/f'tape_{job_id}.csv'  # File
    msdfile = filedir/f'msds_{job_id}.csv'  # File

    # Try to make directory and raise error if it does not work
    try:
        file.parent.mkdir(parents=True)  # Make the simulation directory
    except:
        if file.parent.is_dir() is False:
            # if the parent directory does not exist and mkdir still failed, re-raise an exception
            raise
    print(f'Running simulation {filedir.name}')
    
    # Run simulation
    X, msd = flow_with_srk1(N, L, b, D, h, xi, tmax, R, l, B, s1, s2, lamb, t_save, t_msd,
                          msd_start_time, Deq)
    
    # Save to CSV file
    dfs = []
    for i in range(X.shape[0]):
        df = pd.DataFrame(X[i, :, :])
        df['t'] = t_save[i]
        df['D'] = D #save diffusivities of beads
        df['s1'] = s1 # Save enhancer position
        df['s2'] = s2 # Save promoter position
        dfs.append(df)
    df = pd.concat(dfs, ignore_index=True, sort=False)
    df.set_index(['t'], inplace=True)
    df.to_csv(file)
    df = pd.DataFrame(msd)
    df['t_msd'] = t_msd
    df.to_csv(msdfile)

if __name__ == "__main__":
    main()