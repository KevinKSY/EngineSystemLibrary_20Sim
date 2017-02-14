%{a
%clear
mdl = 'ScaniaDC12ChmelaComb.emx';
xxsimConnect(); 
xxsimOpenModel(mdl);
xxsimProcessModel();
xxsimSaveModel();
simTime = 50;
%{a
%%
EngineSystemParameters_ScaniaD12
close all;

%%
RPMRef = 800:100:1800;
BMEPRef = 4:20;
[RPMRefx, BMEPRefy] = meshgrid(RPMRef,BMEPRef);
TqRef = BMEPRefy.*(RPMRefx/60/2)*(eng.cyl(1).dim.vDisp*eng.nCyl)*100./(RPMRefx/30*pi)*1000;
pRailRef = (600:100:1500)*1e5;
noCycAvg = 10;
CAtoRec = -10:1:100;

%BSFCCase = zeros(length(RPMRef),length(BMEPRef),length(pRailRef));
%dQCase = zeros(length(RPMRef),length(CAtoRec),length(BMEPRef),length(pRailRef));
%pMaxCase = EVC;

%pExhCase = EVC;
%TExhCase = EVC;
%FExhCase = EVC;
%pIntakeCase = EVC;
%TIntakeCase = EVC;
%FIntakeCase = EVC;
%pACompCase = EVC;
%TACompCase = EVC;
%FACompCase = EVC;
%dmeCase = EVC;
%omegaTCCase = EVC;
%turbEffCase = EVC;
%compEffCase = EVC;
%%
%}
logVariables = {'time' ,...
    'EngCylBlock4Stroke.Eng_Cyl1.ROHR.dQ', ...
    'EngCylBlock4Stroke.Eng_Cyl1.CrankMechanism1.q_rad', ...
    'Controller.MultiplyDivide.output',...
    'Controller.Governor.Governor.omegaELP'};
xxsimSetLogVariables(logVariables);
load('C:\Users\yum\Dropbox\Study\NTNU2016S\ssMapScaniaROHRInjM10_2.mat');

for ii = 6:length(pRailRef)   
    for jj = 1:length(BMEPRef)
        for kk = 1:length(RPMRef);
            if BSFCCase(kk,jj,ii) == 0
                dQTemp = zeros(noCycAvg,length(CAtoRec));
                fprintf('Running case no %d %d %d, speed = %d RPM, torque = %d kN \n', ii, jj, kk, RPMRef(kk),TqRef(jj,kk));
                xxsimSetParameters('TqLoad',TqRef(jj,kk));
                xxsimSetParameters('RPMRef',RPMRef(kk));
                xxsimSetParameters('Controller.injectionControl.pRailRef',pRailRef(ii));
                tic
                xxsimRun();
                [values, names] = xxsimGetLogValues(logVariables);
                toc
                if abs(values(end,5)*30/pi - RPMRef(kk)) / RPMRef(kk) < 0.05 & values(end,1) > 49.9 
                    BSFCCase(kk,jj,ii) = mean(values(end-20000:end,4));
                    phiComb = mod(values(end-20000:end,3)*180/pi,720);
                    dQSim = values(end-20000:end,2);
                    phiComb(phiComb > 360) = phiComb(phiComb > 360) - 720;
                    idxEndCyc = find(phiComb(2:end) - phiComb(1:end-1) < 0);
                    idxStartCyc = idxEndCyc + 1;
                    idxEndCyc = idxEndCyc(2:end);
                    idxStartCyc = idxStartCyc(1:end-1);
                    mm = 0;
                    for i = (length(idxStartCyc)-(noCycAvg-1)):length(idxStartCyc)
                        mm = mm + 1;
                        idxTemp = idxStartCyc(i):idxEndCyc(i);
                        dQTemp(mm,:) = interp1(phiComb(idxTemp),dQSim(idxTemp),CAtoRec);
                    end;
                    plot(CAtoRec,dQTemp);
                    dQCase(kk,:,jj,ii) = mean(dQTemp);
                else
                    BSFCCase(kk,jj,ii) = 1;
                end;
                save('C:\Users\yum\Dropbox\Study\NTNU2016S\ssMapScaniaROHRInjM10_2.mat','BSFCCase','dQCase','CAtoRec','pRailRef', ...
                    'BMEPRef','RPMRef');
                xxsimClearLastRun();
            end;
        end;
    end;
end;
