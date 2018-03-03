import pandas as pd
import numpy as np
import datetime as dt

import sza_calc as szac

e = dt.datetime(2015,03,11,16,10)
D = pd.read_csv("R/out/design.csv")

np.random.seed(1)
SZA = np.random.uniform(0,90,100)
Lat = []
Lon = []

llat = np.arange(-90.,90.,0.5)
llon = np.arange(-180.,180.,1.)
print llat
SZA_m =  np.zeros((len(llat),len(llon)))
L = len(llat)
N = len(llon)

for I,lat in enumerate(llat):
    for J,lon in enumerate(llon):
        SZA_m[I,J] = szac.get_sza_as_deg(e, lat, lon)
        pass
    pass

for sza in SZA:
    idx = (np.abs(sza-SZA_m)).argmin()
    I,J = int(idx/L),idx%N
    print I,J,sza,SZA_m[I,J]
    Lat.append(llat[I])
    Lon.append(llon[J])
    pass

print len(Lat)
#print len(SZA) 
D["sza"] = SZA
D["lat"] = Lat
D["lon"] = Lon

D.to_csv("R/out/design_sza_uniform.csv",header=True,index=False)
