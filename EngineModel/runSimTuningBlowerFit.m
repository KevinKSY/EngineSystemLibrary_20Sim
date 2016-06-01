clear
addpath('model'); %'code','data','parameters',
path = 'C:\Users\yum\Dropbox\Propeller engine dynamics\Kevin\8RTFLEX65D';
pathFile = 'C:\temp\SStune';
cd(path);

load('8RT-FLEX68-D.mat');

mdl = 'EngSimulation8RTFLEX68D_SSTuneBlowerFit';

simTime = 300;
exhVVStart = 1.2;

ANS = [];
while ~(strcmp(ANS,'y')||strcmp(ANS,'n'))
    ANS = input('Do you want to delete all the sim result files?(y/n)','s');
end;

if strcmp(ANS,'y')
    cd(pathFile);
    delete('*.*');
    cd(path);
end;

open_system(mdl);
caseInit = 9;
eng.engLoad0 = eng_data.perf.Pe(caseInit)/eng_data.perf.Pe(2);
HTRef = (eng_data.HB.Cyl + eng_data.HB.Radiation)*1000;
EngineSystemParameters8RTFLEX68D;

%% Vessel information
vSDes = 10;
vS0 = 0;
%% Controller mode
vSCont = 0;
engSCont = 1;

%{a
%%
noCase = 2;
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
%%
for caseNo = 12:13
    fileName = ['s',num2str(caseNo),'.mat'];
    cd(pathFile);
    if ~(exist(fileName,'file') == 2)
        cd(path)
        complete = 0;
        k = 0;
        while (complete == 0);
            k = k + 1;
            if k > 10
                break;
            end;
            try
                set_param(mdl, 'LoadInitialState', 'off');
                tic
                simOut = sim(mdl,'SrcWorkspace','current',...
                        'Solver','ode4','FixedStep','1e-3',...
                        'ZeroCross','on',...
                        'StopTime', num2str(simTime), ... 
                        'ZeroCross','on', ...
                        'SaveTime','on',...
                        'SignalLogging','on','SignalLoggingName','logsout');
                toc;                 
            catch err
                fprintf([err.identifier '\n']);
                continue
            end;
            complete = 1;
        end;
        cd(pathFile);
        save(fileName,'simOut');
    else
        load(fileName);
    end;
    cd(path);
    logsout = simOut.get('logsout');
    BSFC = logsout.get('BSFC').Values;
    pMax = logsout.get('pMax').Values;
    dQCyl1 = logsout.get('dQCyl1').Values;
    pMaxCase(caseNo-11) = mean(pMax.Data(end-20000:end));
    BSFCCase(caseNo-11) = mean(BSFC.Data(end-20000:end));
    phiInj(caseNo-11) = mean(logsout.get('phiInj').Values.Data(end-20000:end));
    tempWall(caseNo-11) = mean(logsout.get('tempWall').Values.Data(end-20000:end));
    EVC(caseNo-11) = mean(logsout.get('EVC').Values.Data(end-20000:end));
    pExhCase(caseNo-11) = mean(logsout.get('pTFExh').Values.Data(end-20000:end,1));
    TExhCase(caseNo-11) = mean(logsout.get('pTFExh').Values.Data(end-20000:end,2));
    FExhCase(caseNo-11) = mean(logsout.get('pTFExh').Values.Data(end-20000:end,3));
    pScavCase(caseNo-11) = mean(logsout.get('pTFScav').Values.Data(end-20000:end,1));
    TScavCase(caseNo-11) = mean(logsout.get('pTFScav').Values.Data(end-20000:end,2));
    FScavCase(caseNo-11) = mean(logsout.get('pTFScav').Values.Data(end-20000:end,3));
    pACompCase(caseNo-11) = mean(logsout.get('pTFPipe').Values.Data(end-20000:end,1));
    TACompCase(caseNo-11) = mean(logsout.get('pTFPipe').Values.Data(end-20000:end,2));
    FACompCase(caseNo-11) = mean(logsout.get('pTFPipe').Values.Data(end-20000:end,3));
    dmeCase(caseNo-11) = mean(logsout.get('dme').Values.Data(end-20000:end));
    omegaTCCase(caseNo-11) = mean(logsout.get('omegat').Values.Data(end-20000:end));
    turbEff(caseNo-11) = mean(logsout.get('effTurb').Values.Data(end-20000:end));
    compEff(caseNo-11) = mean(logsout.get('effComp').Values.Data(end-20000:end));
    dQCase(caseNo-11) = mean(dQCyl1.Data(end-20000:end))*eng.nCyl;
    dmBlowerCase(caseNo-11) = mean(logsout.get('dmBlower').Values.Data(end-20000:end));

    figure
    subplot(3,1,1)
    plot(BSFC);
    hold on
    plot([0 simTime],[eng_data.perf.ref.BSFC(caseNo) eng_data.perf.ref.BSFC(caseNo)]);
    subplot(3,1,2)
    plot(pMax)
%    subplot(3,2,3)
%    plot(phiInj)
%    subplot(3,2,4)
%    plot(tempWall)
%    subplot(3,2,5)
%    plot(EVC)
    subplot(3,1,3)
    plot(dQCyl1)
    hold on
    plot([0 simTime],[(eng_data.HB.Cyl(caseNo)+eng_data.HB.Radiation(caseNo))*1000/eng.nCyl (eng_data.HB.Cyl(caseNo)+eng_data.HB.Radiation(caseNo))*1000/eng.nCyl]);
end;  
%%
figure
x = eng_data.perf.Pe(12:13);
subplot(3,3,1)
plot(x,BSFCCase,'*');
hold on
plot(x,eng_data.perf.ref.BSFC(12:13));
hold off
ylim([155 175]);
subplot(3,3,2);
plot(x,pMaxCase/1e5);
ylim([90 170]);
subplot(3,3,3);
%{a
plot(x,TACompCase);
hold on
plot(x,eng_data.scvg.T_acomp(12:13)+273.15);
hold off
ylim([300 500]);
%}
subplot(3,3,4);
plot(x,pScavCase/1e5);
hold on
plot(x,eng_data.scvg.p_scav_g(12:13)+1);
hold off
ylim([1 5]);
subplot(3,3,5);
plot(x,TScavCase);
hold on
plot(x,eng_data.scvg.T_acool(12:13) + 273.15);
hold off
ylim([300 350]);
subplot(3,3,6);
plot(x,pExhCase/1e5);
hold on
%plot(x(1:11),eng_data.TC.p_exh);
hold off
ylim([1 5]);
subplot(3,3,7);
plot(x,TExhCase);
hold on
%plot(x(1:11),eng_data.TC.T_exh_rec + 273.15);
hold off
ylim([500 800]);
subplot(3,3,8);
plot(x,dmeCase);
hold on
plot(x,x.*eng_data.perf.ref.BSEF(12:13)/3600);
hold off
ylim([10 60]);
subplot(3,3,9);
plot(x,dQCase);
hold on
plot(x,HTRef(12:13));
hold off

figure
plot(tempWall,dQCase,'r');

%%
prBlower = [1; (eng_data.scvg.p_scav_g(12:13)+1)*1e5/eng.pAmb];
dmBlowerCorr = [0;dmBlowerCase*1e5/eng.pAmb/sqrt(293.15/eng.tAmb)];
ft = fittype( 'a*exp(-b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 -Inf -Inf];
opts.StartPoint = [0.681120888904715 0.68187900147741 0.241274736593474];
opts.Upper = [10 Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( prBlower, dmBlowerCorr, ft, opts );
coeffBlowerFlow = coeffvalues(fitresult);
% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, prBlower, dmBlowerCorr );
legend( h, 'dmBlowerCorr vs. prBlower', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel prBlower
ylabel dmBlowerCorr
grid on

%%
save('8RTFLEX68DSSTuneBlower','BSFCCase','dmeCase','EVC', ...
    'FExhCase','FScavCase','omegaTCCase','pExhCase','phiInj','pMaxCase','pScavCase', ...
    'tempWall', 'TExhCase', 'TScavCase','TACompCase','pMaxCase','compEff','turbEff','eng',...
    'dmBlowerCase');
    %end;
    %}
%end;
        
