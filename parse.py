import pandas as pd
import datetime as dt

stime = dt.datetime(2015,03,11,15,50)
etime = dt.datetime(2015,03,11,17,19)

T = "%s-%s-%s %s"
D = pd.read_csv("Data/20150311_ott_abs_cleaned.csv", sep=" ",header=None)
D["times"] = [dt.datetime.strptime(T%(rec[0],rec[1],rec[2],rec[3]),"%Y-%m-%d %H:%M:%S") for i,rec in D.iterrows()]
D = D[(D["times"]>=stime) & (D["times"]<=etime)]
D["sec"] = [int(x.split(":")[2]) for x in D[3]]
D = D[D.sec==0]
v1 = D[D.times==dt.datetime(2015,03,11,16,22)][4].tolist()[0]
v2 = D[D.times==dt.datetime(2015,03,11,16,24)][4].tolist()[0]
v = (v1+v2)/2
print v1,v2,v
D.loc[-1] = ["","","","",v,dt.datetime(2015,03,11,16,23),0]
D.index = D.index + 1
D = D.sort_values(by=["times"])
D["attn"] = D[4]
D.to_csv("Data/20150311_ott_abs_parsed.csv",columns=["times","attn"],header=True,index=False)
