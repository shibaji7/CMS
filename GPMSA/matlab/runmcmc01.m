% commands to run the cosmoN example...
addpath('/home/afadikar/Documents/work/GPSMA/TowerTutorial/gpmsa_2015/matlab')
addpath('/home/afadikar/Documents/work/GPSMA/TowerTutorial/sc5/PlotFuns')
addpath('/home/afadikar/Documents/work/GPSMA/TowerTutorial/sc5/Matlab')

nq = 5;
ebdat = ebola02eg(1, nq, 20);  % 01eg just uses data for weeks 1-12
% ebdat = ebola02eg_GrandCapeMount(1, nq);
% ebdat = ebola03eg(1);
% ebdat = ebola04eg(1);
% ebdat = ebola05eg(1);
simData = ebdat.simData;
obsData = ebdat.obsData;
params = setupModel(obsData,simData);
params.priors.lamOs.bLower = .2;
params.priors.lamWs.params = [1 .0001];
params.model.lamVz=200;
params.model.lamOs=1.0;
params.priors.lamOs.params = [10 10];
params.priors.lamVz.params = [1 1.0000e-04];
%params.priors.lamVz.params = [10000000 1000];


nburn = 100; 
nlev = 9;
pout = stepsize(params,nburn,nlev);

pout=gpmmcmc(pout,10000);
save('pout_10000_obs20_dsim_wide.mat', 'pout');
save('pout_50000_dsim68.mat', 'pout');
save('pout_GrandCapeMount_modelQ_week.mat', 'pout');
save('pout_10000_GrandCapeMount.mat', 'pout');

% pout1 =pout; % pout1 conditions just on data along the linear part
% save pout1 pout1;


showPvals(pout.pvals);

ip = round(linspace(900,5090,50));
ip = round(linspace(900,10900,500));
ip = round(linspace(900,50900,100));

% plots
diagPlots(pout,ip,1)
% figure(1); print -depsc2 rho01.eps
plotsEpi_new(pout,ip,1)
plotsEpi_new(pout,ip,20)
plotsEpi_new(pout,ip,2)
% figure(2); print -depsc2 theta.eps
plotsEpi_new(pout,ip,3)
plotsEpi_new(pout,ip,31)
% figure(3); print -depsc2 sens.eps
plotsEpi_new(pout,ip,4)
plotsEpi_new(pout,ip,41)
plotsEpi_new(pout,round(linspace(900,10900,2000)),42)
% figure(41); print -depsc2 pred.eps

plotsEpi_new(pout,round(linspace(900,10900,200)),5);
% figure(51); print -depsc2 wphi.eps
load('../Data/sima.mat');
load('../Data/sima_GrandCapeMount.mat');
holdoutEpi3(pout, [1 17 94], .9, sima)
holdoutEpi3(pout, [1 55 96], .9, sima)
holdoutEpi3(pout, [1 55 96], .9, sima_GrandCapeMount)
holdoutEpi4(pout, [1 17 94], .9, sima)
plotsEpi(pout,ip,61)


figure(1); print -depsc rhobox.eps;
figure(2); print -depsc postTheta.eps;
figure(3); print -depsc thetasens.eps;
figure(4); print -depsc fit.eps;
figure(5); print -depsc pcgp.eps;
figure(51); print -depsc pcgp2.eps;
figure(41); print -depsc pred.eps;
figure(99); print -depsc holdout.eps;

% png figures
figure(1); print -dtiff rhobox.tif;
figure(2); print -dtiff thetabiv.tif;
figure(3); print -dtiff thetasens.tif;
figure(4); print -dtiff fit.tif;

%--------------------------------
% Post runmcmc
%--------------------------------

plotsEpi(pout_8,ip,2);
print -dtiff plot_postdist_8.tiff;
plotsEpi(pout_8,ip,3);
print -dtiff plot_respcurv_8.tiff;
plotsEpi(pout_50,ip,4);
print -dtiff plot_calibr_50.tiff;
%plotsEpi(pout_6,ip,5);
%print -dtiff plot_calibr_pred_6.tiff;
%plotsEpi(pout,ip,41)
%print -dtiff plot__6.tiff;
%plotsEpi(pout,ip,61)
%print -dtiff plot__6.tiff;

plot(pout.simData.orig.Dsim)%, 'color',[0.5,0.5,0.5]);
xlabel('weeks');
axis([1 50 0 0.7]);
