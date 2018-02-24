import pandas as pd
import numpy as np
import datetime as dt

import sza_calc as szac

e = dt.datetime(2015,03,11,16,10)
D = pd.read_csv("R/out/design.csv")

SZA = []
Lat = []
Lon = []
while len(SZA)<100:
    lat = np.random.uniform(-90.,90,1)[0]
    lon = np.random.uniform(-180.,180,1)[0]
    sza = szac.get_sza_as_deg(e, lat, lon)
    if sza <=90.:
        Lat.append(lat)
        Lon.append(lon)
        SZA.append(sza)
        pass
    pass

print len(SZA) 
D["sza"] = SZA
D["lat"] = Lat
D["lon"] = Lon

D.to_csv("R/out/design_sza.csv",header=True,index=False)
