%{a
clear
load('8RT-FLEX68-D.mat');
mdl = '8RTFLEX68DMap.emx';

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
    'DieselEngine2Stroke.EngineControl.EngineControl.phiInj',...
    'DieselEngine2Stroke.EngineControl.EngineControl.exh_VV_dur',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.p',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.T',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.F',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.ROHR.phi_comb'};
xxsimSetLogVariables(logVariables);
xxsimSetParameters('DieselEngine2Stroke.BoundaryIn.T',eng_data.condition.ref.T_amb+273.15);    
xxsimSetParameters('tCW',eng_data.condition.ref.T_cw_scav + 273.15);    
fig1 = figure;
fig2 = figure;
fig3 = figure;
ax1 = axes('Parent',fig1);
ax2 = axes('Parent',fig2);
ax3 = axes('Parent',fig3);
hold(ax1,'on');
hold(ax2,'on');
hold(ax3,'on');
for caseNo = 1:noCase
    xxsimSetParameters('ConstantRPMRef.RPMRef', eng_data.perf.RPM(caseNo));
    xxsimRun();
    [values, names] = xxsimGetLogValues(logVariables);
    tempWall(caseNo) = mean(values(end-20000:end,2));
    pMaxCase(caseNo) = mean(values(end-20000:end,3));
    BSFCCase(caseNo) = mean(values(end-20000:end,4));
    pExhCase(caseNo) = mean(values(end-20000:end,5));
    TExhCase(caseNo) = mean(values(end-20000:end,6));
    FExhCase(caseNo) = mean(values(end-20000:end,7));
    pScavCase(caseNo) = mean(values(end-20000:end,8));
    TACoolCase(caseNo) = mean(values(end-20000:end,9));
    FScavCase(caseNo) = mean(values(end-20000:end,10));
    pACompCase(caseNo) = mean(values(end-20000:end,11));
    TACompCase(caseNo) = mean(values(end-20000:end,12));
    FACompCase(caseNo) = mean(values(end-20000:end,13));
    dmeCase(caseNo) = mean(values(end-20000:end,14));
    omegaTCCase(caseNo) = mean(values(end-20000:end,15));
    compEff(caseNo) = mean(values(end-20000:end,16));
    turbEff(caseNo) = mean(values(end-20000:end,17));
    dQCase(caseNo) = mean(values(end-20000:end,18));
    dmBlowerCase(caseNo) = mean(values(end-20000:end,19));
    phiInj(caseNo) = mean(values(end-20000:end,20));
    EVC(caseNo) = mean(values(end-20000:end,21));
    save('SSVeriResult.mat','tempWall','pMaxCase','BSFCCase','pExhCase', ...
        'TExhCase','FExhCase','pScavCase','TACoolCase','FScavCase',...
        'pACompCase','TACompCase','FACompCase','dmeCase','omegaTCCase',...
        'compEff','turbEff','dQCase','dmBlowerCase','phiInj','EVC');
    plotCylPressure(ax1,values(:,25),values(:,22));
    plotCylPressure(ax2,values(:,25),values(:,23));
    plotCylPressure(ax3,values(:,25),values(:,24));
end;  
%}
%%
load('SSVeriResult.mat')
fig = figure;
width = 14;
height = 10;
margin = 0.1;
name = 'PropCurve';

set(fig, 'Units','centimeters','PaperUnits','centimeters')
set(fig,'Position',[1 1 width height],...
       'PaperPosition',[0 0 width+margin height+margin],...
       'PaperSize',[width+margin height+margin],...
       'PaperPositionMode','auto',...
       'InvertHardcopy', 'on',...
       'Renderer','painters'...     
   );
x = eng_data.perf.Pe(1:noCase);
dataToPlotX = x;
noPlot = [2;1;1;2];
dataToPlotY1 = {TExhCase;TACompCase;BSFCCase;dmeCase;pExhCase/1e5;pScavCase/1e5};
dataToPlotY2 = {eng_data.TC.T_exh_rec+273.15;eng_data.TC.T_acomp+273.15; ...
    eng_data.perf.ref.BSFC(1:noCase);eng_data.perf.ref.BSEF.*(x)/3600; ...
    eng_data.TC.p_exh;eng_data.TC.p_scvg};
legendS = {'$T_\mathrm{exh,sim}$';'$T_\mathrm{exh,ref}$';'$T_\mathrm{acomp,sim}$';...
    '$T_\mathrm{acomp,ref}$';'$\mathrm{BSFC}_\mathrm{sim}$';'$\mathrm{BSFC}_\mathrm{ref}$';...
    '$\dot m_\mathrm{exh,sim}$'; '$\dot m_\mathrm{exh,ref}$';'$p_\mathrm{exh,sim}$';...
    '$p_\mathrm{exh,ref}$';'$p_\mathrm{scav,sim}$';'$p_\mathrm{scav,ref}$'};
xlabel = 'Power (kW)';
ylabel = {'Temperature (K)';'BSFC (g/kWh)';'Mass flow (kg/s)';'Pressure (bar)'};
k = 0;
%%
for i = 1:4
    ax(i) = axes('Parent',fig);
    hold(ax(i),'on');
    for j = 1:noPlot(i)
        if j == 1
            marker = '*';
            lineS = '-';
        else
            marker = '+';
            lineS = ':';
        end;
        k = k + 1;
        plot(ax(i),x(1:length(dataToPlotY1{k})),dataToPlotY1{k},'LineWidth',1,'LineStyle',lineS);
        plot(ax(i),x(1:length(dataToPlotY2{k})),dataToPlotY2{k},'LineWidth',1,'LineStyle','none','Marker',marker);
    end;
    legend(ax(i),legendS(2*(k-noPlot(i))+1:k*2),'Box','on','Interpreter','latex');
    ax(i).Position = [0.1+(mod(i,2)-1)*-0.5 0.6-floor(i/3)*0.5 0.375 0.375];
    ax(i).XLabel.String = xlabel;
    ax(i).XLabel.Interpreter = 'latex';
    ax(i).YLabel.String = ylabel{i};
    ax(i).YLabel.Interpreter = 'latex';
    ax(i).XGrid = 'on'
    ax(i).XMinorTick = 'on'
    ax(i).XMinorGrid = 'on'
    ax(i).YMinorTick = 'on'
    ax(i).YMinorGrid = 'on'
    ax(i).YGrid = 'on'
    ax(i).XLim = [5 30.0]*1000;
end;
saveas(fig,'validResult')    
saveas(fig,'validResult','pdf')

ax(2) = axes('Parent',fig);
ax(3) = axes('Parent',fig);
ax(4) = axes('Parent',fig);
plot(x,BSFCCase,'*');
plot(x,eng_data.perf.ref.BSFC(1:noCase));
%%

subplot(3,3,1)

hold on

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
EVO = [0.993926872714363;1.00000966342711;1.00440305233587;1.00664126461662;...
     1.00906510672204;1.01157981420113;1.01410582111898;1.01690945755152;...
     1.0198116966627;1.02676975942776;1.04006192127438;1.055884717629;1.06527239215165];
    
EVCAngle = 125.76*EVO + ...
    eng.cyl(1).exhVVProf.dCALiftUp + eng.cyl(1).exhVVProf.dCALiftTopRef*EVC+ ... 
    eng.cyl(1).exhVVProf.dCALiftDown;
subplot(1,2,1)
plot(x,EVCAngle);
subplot(1,2,2)
plot(x,phiInj);

figure
plot(HTRef,dQCase);
hold on
plot([0 5e5],[0 5e5],':');