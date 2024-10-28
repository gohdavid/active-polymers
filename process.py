import numpy as np
import pandas as pd
from pathlib import Path
import sys
from fractions import Fraction
from act_pol.analysis.files import process_sim
import re
from multiprocessing import Pool

if len(sys.argv) < 5:
    print(("Usage: python flow_sim.py <job_id> <velocity_prefactor> "
            "<friction_ratio> <activity_ratio> <E-P tether length> <reciprocity boolean>"))
    sys.exit(1)

# Free parameters
B = float(sys.argv[2])  # Strength of condensate-to-promoter force
enhancer_friction_ratio = float(sys.argv[3])  # Friction coefficient of enhancer
enhancer_activity_ratio = float(Fraction(sys.argv[4]))  # Activity ratio for the enhancer
Lep_kb = float(sys.argv[5])  # Enhancer-promoter separation in kb
reciprocal = int(sys.argv[6])  # Whether the force also acts on the promoter

# Fixed parameters
kb = 80.10471204188482 # nm per kb
Lk = 35.36  # Kuhn length in nm
Lc = 250*kb # 300 kb in nm
N = round(Lc/Lk) + 1  # Number of beads
Lep = round(Lep_kb*kb/Lk)  # Enhancer-promoter separation in units of Kuhn length
mid = (N-1)/2  # Index to make enhancer and promoter symmetric about the polymer midpoint
s1 = round(mid - Lep/2)  # Enhancer position
s2 = round(mid + Lep/2)  # Promoter position

# Name of simulation file
filedir = Path(f"./simulations/B{B:.3g}_F{enhancer_friction_ratio:.3g}_A{enhancer_activity_ratio:.3g}_L{Lep_kb:.3g}_R{reciprocal:.3g}/")  # Simulation directory
files = list(filedir.glob("./tape*.csv"))
print("Start",flush=True)
def process_file(file):
    X = process_sim(file)[0]  # Assuming process_sim is defined elsewhere
    return np.diff(X[:, [s1, s2], :],axis=1)
total_processes = 4 * 48
with Pool(processes=total_processes) as pool:
    results = pool.map(process_file, files)
concat_X = np.vstack(results)
npfile = filedir / 'concatenated_results.npy'
np.save(npfile, concat_X)
print(f"Concatenated array saved to {npfile}")