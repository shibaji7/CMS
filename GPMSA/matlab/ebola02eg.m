function params=ebola02eg(doPlot, nq, obslength);

if ~exist('doPlot'); doPlot=0; else; doPlot=1; end

% read in the sim data

%  ysimNative = textread('../Data/sim5Q28x500.txt');
%  dsn = strcat('sim',num2str(nq),'Q28X500.txt');
%  ysimNative = textread(strcat('../Data/', dsn));
 ysimNative = textread('../Data/sim5Q57.txt');
 ysim = ysimNative;
 ysim = log(ysimNative);
 [neta m] = size(ysim);
 time = [1:neta]';

 % make the designs
 designNative = textread('../Data/slhs-100x5.txt');
 dmat1 = repmat(designNative,[5 1]);
 design01 = to01(designNative);
 designQ = linspace(.05,.95, nq)';
 dmatQ = repmat(designQ,[200 1]);
 
%  designNative = [dmatQ dmat1];
%  design01 = [dmatQ to01(dmat1)];
 
 % now m1=5, m2=100; design01 is 100x5; ysim is neta x 100
 
  if(doPlot)
     figure(1); clf;
     plotmatrix(design01);
 end
 if(doPlot)
     figure(2); clf;
     plot(time,ysim); 
 end


 % read in the observations
 Ndat = obslength;  % use only first 12 weeks of data
 obsdat = textread('../Data/obs2x28.txt');
 obsdat = obsdat(1:Ndat,:);
 
 ydat = obsdat(:,2); ydat = log(ydat);
 tdat = obsdat(:,1);
 Sigy = textread('../Data/lnCountCov28x28.txt');
 Sigy = Sigy(1:Ndat,1:Ndat);
 
 [neta m] = size(ysim);

 n = 1; % number of experiments
  % create the raw data and sd that goes with it; right now we'll assume
  % this sd makes sense, and so does this time alignment
 yobs(1).y = ydat; yobs(1).time = tdat; 
 yobs(1).Sigy = Sigy; 
 
  % Standardize the data
 ysimmean=repmat(mean(ysim,2),size(time));
 ysimmean=mean(ysim,2);
 ysimsd=std(ysim(:));
 ysimStd=(ysim-repmat(ysimmean,[1 m])) /ysimsd;
  % interpolate to data grid and standardize experimental data
    for ii=1:n
      yobs(ii).ymean=interp1(time,ysimmean,yobs(ii).time);
      yobs(ii).yStd=(yobs(ii).y-yobs(ii).ymean)/ysimsd;
    end
 if(doPlot)
     figure(3); clf;
     plot(time,ysimStd); hold on;
     plot(yobs.time,yobs.yStd,'ko')
 end

% K basis - build the PC basis
  % compute on simulations % 99.7 and .3% for the first 2 pc's
    pu=5;
    [U,S,V]=svd(ysimStd,0);
    Ksim=U(:,1:pu)*S(1:pu,1:pu)./sqrt(m);
    if(doPlot)
        figure(4);
        plot(time,Ksim);
        %figure(2); print -deps2c cipdssMortpc.eps;
    end
  % interpolate K onto data grids
    for ii=1:n
      yobs(ii).Kobs=zeros(length(yobs(ii).yStd),pu);
      for jj=1:pu
        yobs(ii).Kobs(:,jj)=interp1(time,Ksim(:,jj),yobs(ii).time);
      end
    end

    % D basis - build the discrepancy basis
  % lay it out, and record decomposition on sim and data grids
    % Kernel centers and widths
      Dgrid=-2:10:68; Dwidth=15; 
      pv=length(Dgrid);
    % Compute the kernel function map, for each kernel
      Dsim=zeros(size(ysimStd,1),pv);
      for ii=1:n; yobs(ii).Dobs=zeros(length(yobs(ii).yStd),pv); end
      for jj=1:pv
        % first the obs
          for ii=1:n
            yobs(ii).Dobs(:,jj)=normpdf(yobs(ii).time,Dgrid(jj),Dwidth);
          end
        % now the sim
          Dsim(:,jj)=normpdf(time,Dgrid(jj),Dwidth);
      end
    % normalize the D maps
      Dmax=max(max(Dsim*Dsim'));
      Dsim=Dsim/sqrt(Dmax);
      for ii=1:n; yobs(ii).Dobs=yobs(ii).Dobs/sqrt(Dmax); end
      
      
% record the data into the obsData and simData structures.
  % First simData
    % required fields
      simData.x   = {.5,design01,designQ};
      %simData.x   = [.5*ones(size(dmatQ)) design01];
      simData.yStd=ysimStd;
      simData.Ksim=Ksim;
    % extra fields: original data and transform stuff
      simData.orig.y=ysim;
      simData.orig.ymean=ysimmean;
      simData.orig.ysd=ysimsd;
      simData.orig.Dsim=Dsim;
      simData.orig.time=time;
    % fields to hold the hold out design and values
%       simData.orig.itrain = itrain;
%       simData.orig.ihold = ihold;
%       simData.orig.design01ho = design01ho;
%       simData.orig.yho = ysimho;
      simData.orig.designNative = designNative;
      simData.orig.designQ = designQ;
  % obsData
  % set the dummy x values to .5; we're treating all inputs as
  % parameters to be calibrated.
  x = [.5];
    for ii=1:n
      % required fields
        obsData(ii).x   =x(ii);
        obsData(ii).yStd=yobs(ii).yStd;
        obsData(ii).Kobs=yobs(ii).Kobs;
        obsData(ii).Dobs=yobs(ii).Dobs;
        obsData(ii).Sigy=yobs(ii).Sigy./(ysimsd.^2); 
      % extra fields
        obsData(ii).orig.y=yobs(ii).y;
        obsData(ii).orig.ymean=yobs(ii).ymean;
        obsData(ii).orig.time =yobs(ii).time;
%         obsData(ii).orig.thetatrue = design01ho(itrue,:);
    end

% some bookkeeping stuff useful for later plots ...
%obsData.orig.thetatrue = designfull(itrue,:);
q=size(designNative,2)+size(designQ,2);
simData.orig.colmax = max(designNative); simData.orig.colmax(q)=1;
simData.orig.colmin = min(designNative); simData.orig.colmin(q)=0;
%obsData.orig.thetatrueNative = designNative(itrue+m,:);

% pack up and leave
params.simData=simData;
params.obsData=obsData;
      

end
