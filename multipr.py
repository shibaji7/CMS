import multiprocessing as mpr
import os
import pandas as pd

def run_code(l):
    cmd = "python model.py %.15f %.15f" % (l[0],l[1])
    print cmd
    os.system(cmd)
    return

D = pd.read_csv("R/out/design.csv")
d = D.as_matrix()

pool = mpr.Pool(10)
pool.map(run_code, d)
