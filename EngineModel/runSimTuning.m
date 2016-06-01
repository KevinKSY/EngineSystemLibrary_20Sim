clear
load('8RT-FLEX68-D.mat');
mdl = '8RTFLEX68DSSTuneOpt.emx';

xxsimConnect();
xxsimOpenModel(mdl);
xxsimProcessModel();
simTime = 200;
%%
caseInit = 9;
eng.engLoad0 = eng_data.perf.Pe(caseInit)/eng_data.perf.Pe(2);
EngineSystemParameters8RTFLEX68D
HTRef = (eng_data.HB.Cyl + eng_data.HB.Radiation)*1000/eng_data.dim.no_cyl;

%%
noCase = 13;
phiInj = zeros(noCase,1);
EVC = phiInj;
tempWall = EVC;
pMaxCase = EVC;
BSFCCase = EVC;
pExhCase = EVC;
TExhCase = EVC;
FExhCase = EVC;
pScavCase = EVC;
TScavCase = EVC;
FScavCase = EVC;
pACompCase = EVC;
TACompCase = EVC;
FACompCase = EVC;
dmeCase = EVC;
omegaTCCase = EVC;
turbEffCase = EVC;
compEffCase = EVC;
dQCase = EVC;
dmBlowerCase = EVC;
pCompCase = EVC;
%%
logVariables = {'time' ,...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel1.R1.pTwall.e', ...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.pMaxFinder.pMax', ...
    'DieselEngine2Stroke.EngineControl.BSFC_calc.output',...
    'DieselEngine2Stroke.ExhaustReceiver.Thdyn_Cont_Vol_Cyl.p',...
    'DieselEngine2Stroke.ExhaustReceiver.Thdyn_Cont_Vol_Cyl.T', ...
    'DieselEngine2Stroke.ExhaustReceiver.Thdyn_Cont_Vol_Cyl.F',...
    'DieselEngine2Stroke.ScavReceiver.Thdyn_Cont_Vol_Cyl.p',...
    'DieselEngine2Stroke.TurbochargingSystem.ScavengeAirCooler1.Submodel2.T_out',...
    'DieselEngine2Stroke.ScavReceiver.Thdyn_Cont_Vol_Cyl.F',...
    'DieselEngine2Stroke.TurbochargingSystem.pipeBCool1.Thdyn_Cont_Vol_Cyl.p',...
    'DieselEngine2Stroke.TurbochargingSystem.pipeBCool1.Thdyn_Cont_Vol_Cyl.T',...
    'DieselEngine2Stroke.TurbochargingSystem.pipeBCool1.Thdyn_Cont_Vol_Cyl.F',...
    'DieselEngine2Stroke.ExhaustReceiver.p8.f[1]',...
    'DieselEngine2Stroke.TurbochargingSystem.Turbocharger1.Shaft.p.f',...
    'DieselEngine2Stroke.TurbochargingSystem.Turbocharger1.COMPRES1.etaic',...
    'DieselEngine2Stroke.TurbochargingSystem.Turbocharger1.TURBIN1.eta_t',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel1.pQ.f',...
    'DieselEngine2Stroke.TurbochargingSystem.Blower1.pC_in.f[1]',...
    'DieselEngine2Stroke.EngineControl.Controller2.outputInj',...
    'DieselEngine2Stroke.EngineControl.Controller2.outputEVC',...
    'DieselEngine2Stroke.EngineControl.Controller2.p_compOut'};
    
xxsimSetLogVariables(logVariables);
for caseNo = 1:noCase
    caseNo
    xxsimSetParameters('ConstantRPMRef.RPMRef', eng_data.perf.RPM(caseNo));
    xxsimSetParameters('DieselEngine2Stroke.Constant.BSFCRef', eng_data.perf.ref.BSFC(caseNo));
    xxsimSetParameters('DieselEngine2Stroke.Constant1.QCylRef', HTRef(caseNo));
    xxsimSetParameters('DieselEngine2Stroke.BoundaryIn.T',eng_data.condition.ref.T_amb+273.15);
    xxsimSetParameters('tCW',eng_data.condition.ref.T_cw_scav + 273.15);    
    xxsimRun();
    [values, names] = xxsimGetLogValues(logVariables);
    tempWall(caseNo) = mean(values(end-2000:end,2));
    pMaxCase(caseNo) = mean(values(end-2000:end,3));
    BSFCCase(caseNo) = mean(values(end-2000:end,4));
    pExhCase(caseNo) = mean(values(end-2000:end,5));
    TExhCase(caseNo) = mean(values(end-2000:end,6));
    FExhCase(caseNo) = mean(values(end-2000:end,7));
    pScavCase(caseNo) = mean(values(end-2000:end,8));
    TACoolCase(caseNo) = mean(values(end-2000:end,9));
    FScavCase(caseNo) = mean(values(end-2000:end,10));
    pACompCase(caseNo) = mean(values(end-2000:end,11));
    TACompCase(caseNo) = mean(values(end-2000:end,12));
    FACompCase(caseNo) = mean(values(end-2000:end,13));
    dmeCase(caseNo) = mean(values(end-2000:end,14));
    omegaTCCase(caseNo) = mean(values(end-2000:end,15));
    compEff(caseNo) = mean(values(end-2000:end,16));
    turbEff(caseNo) = mean(values(end-2000:end,17));
    dQCase(caseNo) = mean(values(end-2000:end,18));
    dmBlowerCase(caseNo) = mean(values(end-2000:end,19));
    phiInj(caseNo) = mean(values(end-2000:end,20));
    EVC(caseNo) = mean(values(end-2000:end,21));
    pCompCase(caseNo) = mean(values(end-2000:end,22))/1e5;

    
    
    
    %

end;  
%%
figure
x = eng_data.perf.Pe(1:noCase);
subplot(3,3,1)
plot(x,BSFCCase,'*');
hold on
plot(x,eng_data.perf.ref.BSFC(1:noCase));
hold off
ylim([155 175]);
subplot(3,3,2);
plot(x,pMaxCase/1e5);
ylim([90 170]);
subplot(3,3,3);
%{a
plot(x,TACompCase);
hold on
plot(x(1:11),eng_data.TC.T_acomp+273.15);
hold off
ylim([300 500]);
%}
subplot(3,3,4);
plot(x,pScavCase/1e5);
hold on
plot(x(1:11),eng_data.TC.p_scvg);
hold off
ylim([1 5]);
subplot(3,3,5);
plot(x,TACoolCase);
hold on
plot(x(1:11),eng_data.TC.T_acool + 273.15);
hold off
ylim([300 350]);
subplot(3,3,6);
plot(x,pExhCase/1e5);
hold on
plot(x(1:11),eng_data.TC.p_exh);
hold off
ylim([1 5]);
subplot(3,3,7);
plot(x,TExhCase);
hold on
plot(x(1:11),eng_data.TC.T_exh_rec + 273.15);
hold off
ylim([500 800]);
subplot(3,3,8);
plot(x,dmeCase);
hold on
plot(x,x.*eng_data.perf.ref.BSEF(1:noCase)/3600);
hold off
ylim([10 60]);
subplot(3,3,9);
plot(x,dQCase);
hold on
plot(x,HTRef(1:noCase));
hold off

figure
EVCAngle = eng.cyl(1).exhVVProf.cAStartRef*eng.control.EVO + ...
    eng.cyl(1).exhVVProf.dCALiftUp + eng.cyl(1).exhVVProf.dCALiftTopRef*EVC+ ... 
    eng.cyl(1).exhVVProf.dCALiftDown;
subplot(1,2,1)
plot(x,EVCAngle);
subplot(1,2,2)
plot(x,phiInj);

figure
tempWall = [273.15+36; tempWall];
dQCase = [0;dQCase]/1000*eng_data.dim.noStroke;

[xData, yData] = prepareCurveData( tempWall, dQCase );

% Set up fittype and options.
ft = fittype( 'poly2' );
excludedPoints = excludedata( xData, yData, 'Indices', [11 12 14] );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Exclude = excludedPoints;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
coeffEngCool = coeffvalues(fitresult);
% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData, excludedPoints );
legend( h, 'dQCase vs. tempWall', 'Excluded dQCase vs. tempWall', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel tempWall
ylabel dQCase
grid on

%%
save('8RTFLEX68DSSTuneFinal','BSFCCase','dmeCase','EVC', ...
    'FExhCase','FScavCase','omegaTCCase','pExhCase','phiInj','pMaxCase','pScavCase', ...
    'tempWall', 'TExhCase', 'TScavCase','TACompCase','pMaxCase','compEff','turbEff','eng', ...
    'dmBlowerCase','dQCase','pCompCase');
    %end;
    %}
%end;
        
