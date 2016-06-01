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
fval = EVC;
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
load('OptResult.mat');
for caseNo = 1:noCase
    caseNo
    if EVC(caseNo) == 0
        xxsimSetParameters('caseNo', caseNo);
        xxsimSetParameters('DieselEngine2Stroke.BoundaryIn.T',eng_data.condition.ref.T_amb+273.15);
        xxsimSetParameters('tCW',eng_data.condition.ref.T_cw_scav + 273.15);    
        costFnc = @(x)runSimForOpt(x);
        A = []; b = []; Aeq = []; beq = [];
        lb = [-5, 0.5, 0.5];
        ub = [5, 2, 2];
        if caseNo == 1
            x0 = [0, 1, 1];
        else
            x0 = [-1.3100062634938;1.040687517865;1.3227493482579];%[phiInj(caseNo-1), EVO(caseNo-1), EVC(caseNo-1)];
        end;
        [x, fval(caseNo)] = fmincon(costFnc,x0,A,b,Aeq,beq,lb,ub);
        xxsimClearRun(0);
        phiInj(caseNo) = x(1);
        EVO(caseNo) = x(2);
        EVC(caseNo) = x(3);
        save('OptResult.mat','EVO','EVC','phiInj','fval');
    end;
end;  
%%
% figure
% x = eng_data.perf.Pe(1:noCase);
% subplot(3,3,1)
% plot(x,BSFCCase,'*');
% hold on
% plot(x,eng_data.perf.ref.BSFC(1:noCase));
% hold off
% ylim([155 175]);
% subplot(3,3,2);
% plot(x,pMaxCase/1e5);
% ylim([90 170]);
% subplot(3,3,3);
% %{a
% plot(x,TACompCase);
% hold on
% plot(x(1:11),eng_data.TC.T_acomp+273.15);
% hold off
% ylim([300 500]);
% %}
% subplot(3,3,4);
% plot(x,pScavCase/1e5);
% hold on
% plot(x(1:11),eng_data.TC.p_scvg);
% hold off
% ylim([1 5]);
% subplot(3,3,5);
% plot(x,TACoolCase);
% hold on
% plot(x(1:11),eng_data.TC.T_acool + 273.15);
% hold off
% ylim([300 350]);
% subplot(3,3,6);
% plot(x,pExhCase/1e5);
% hold on
% plot(x(1:11),eng_data.TC.p_exh);
% hold off
% ylim([1 5]);
% subplot(3,3,7);
% plot(x,TExhCase);
% hold on
% plot(x(1:11),eng_data.TC.T_exh_rec + 273.15);
% hold off
% ylim([500 800]);
% subplot(3,3,8);
% plot(x,dmeCase);
% hold on
% plot(x,x.*eng_data.perf.ref.BSEF(1:noCase)/3600);
% hold off
% ylim([10 60]);
% subplot(3,3,9);
% plot(x,dQCase);
% hold on
% plot(x,HTRef(1:noCase));
% hold off
% 
% figure
% EVCAngle = eng.cyl(1).exhVVProf.cAStartRef*eng.control.EVO + ...
%     eng.cyl(1).exhVVProf.dCALiftUp + eng.cyl(1).exhVVProf.dCALiftTopRef*EVC+ ... 
%     eng.cyl(1).exhVVProf.dCALiftDown;
% subplot(1,2,1)
% plot(x,EVCAngle);
% subplot(1,2,2)
% plot(x,phiInj);
% 
% figure
% tempWall = [273.15+36; tempWall];
% dQCase = [0;dQCase]/1000*eng_data.dim.noStroke;
% 
% [xData, yData] = prepareCurveData( tempWall, dQCase );
% 
% % Set up fittype and options.
% ft = fittype( 'poly2' );
% excludedPoints = excludedata( xData, yData, 'Indices', [11 12 14] );
% opts = fitoptions( 'Method', 'LinearLeastSquares' );
% opts.Exclude = excludedPoints;
% 
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );
% coeffEngCool = coeffvalues(fitresult);
% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData, excludedPoints );
% legend( h, 'dQCase vs. tempWall', 'Excluded dQCase vs. tempWall', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% xlabel tempWall
% ylabel dQCase
% grid on
% 
% %%
% save('8RTFLEX68DSSTuneFinal','BSFCCase','dmeCase','EVC', ...
%     'FExhCase','FScavCase','omegaTCCase','pExhCase','phiInj','pMaxCase','pScavCase', ...
%     'tempWall', 'TExhCase', 'TScavCase','TACompCase','pMaxCase','compEff','turbEff','eng', ...
%     'dmBlowerCase','dQCase','pCompCase');
%     %end;
%     %}
% %end;
%         
