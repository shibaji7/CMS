import multiprocessing as mpr
import os
import pandas as pd

out = "out_sza_unif"

def run_code(l):
    #print type(l[0]),type(l[1]),type(l[]
    cmd = "python model.py %.15f %.15f %.15f %.15f %.15f %s" % (float(l[0]),float(l[1]),float(l[2]),float(l[3]),float(l[4]), out)
    print cmd
    os.system(cmd)
    return

D = pd.read_csv("R/out/design_sza.csv")
d = D.as_matrix()

pool = mpr.Pool(10)
pool.map(run_code, d)
