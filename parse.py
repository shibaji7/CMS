import pandas as pd
import datetime as dt
from scipy.interpolate import interp1d

stime = dt.datetime(2015,03,11,15,50)
etime = dt.datetime(2015,03,11,17,19)
M = int((etime-stime).total_seconds()/60)+1
TC = [stime + dt.timedelta(minutes=x) for x in range(M)]

#T = "%s-%s-%s %s"
#D = pd.read_csv("Data/20150311_ott_abs_cleaned.csv", sep=" ",header=None)
#D["times"] = [dt.datetime.strptime(T%(rec[0],rec[1],rec[2],rec[3]),"%Y-%m-%d %H:%M:%S") for i,rec in D.iterrows()]
#D = D[(D["times"]>=stime) & (D["times"]<=etime)]
#D["sec"] = [int(x.split(":")[2]) for x in D[3]]
#D = D[D.sec==0]
#v1 = D[D.times==dt.datetime(2015,03,11,16,22)][4].tolist()[0]
#v2 = D[D.times==dt.datetime(2015,03,11,16,24)][4].tolist()[0]
#v = (v1+v2)/2
#print v1,v2,v
#D.loc[-1] = ["","","","",v,dt.datetime(2015,03,11,16,23),0]
#D.index = D.index + 1
#D = D.sort_values(by=["times"])
#D["attn"] = D[4]
#D.to_csv("Data/20150311_ott_abs_parsed.csv",columns=["times","attn"],header=True,index=False)

import glob
files = glob.glob("Data/raw/*.txt")

test = True
test = False

for f in files:
    try:
        print f
        Time = []
        abs_v = []
        with open(f,"rb") as code: lines = code.readlines()
        for l in lines:
            l = filter(None,l.split(" "))
            T = int(l[3].split(":")[-1])
            if T == 0:
                Time.append(dt.datetime.strptime(l[0]+l[1]+l[2]+l[3],"%Y%m%d%H:%M:%S"))
                abs_v.append(float(l[-1].replace("\r\n","")))
            pass
        df = pd.DataFrame()
        df["times"] = Time
        df["absv"] = abs_v
        df = df[(df.times>=stime) & (df.times<=etime)]
        tc = df.times.tolist()
        for t in TC:
            if t not in tc:
                tm1 = df[df.times==t-dt.timedelta(minutes=1)].absv.tolist()[0]
                tp1 = df[df.times==t+dt.timedelta(minutes=1)].absv.tolist()[0]
                ti = (tm1+tp1)/2
                df.loc[-1] = [t,ti]
                df.index = df.index + 1
                print t
                df = df.sort_values(by="times")
                pass
            pass
        #print len(df)
        if test: break
        df.to_csv(f.replace("txt","csv").replace("raw","csv"),header=True,index=False)
    except:
        print "loop"
    pass
