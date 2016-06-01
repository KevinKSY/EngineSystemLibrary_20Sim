clear
load('8RT-FLEX68-D.mat');
mdl = '8RTFLEX68DStepResp.emx';

xxsimConnect();
xxsimOpenModel(mdl);
xxsimProcessModel();
simTime = 200;

caseInit = 9;
eng.engLoad0 = eng_data.perf.Pe(caseInit)/eng_data.perf.Pe(2);
EngineSystemParameters8RTFLEX68D

%%
initRPM = [70.0;84.4];
finalRPM = [95.0;95.0];
amplitude = finalRPM - initRPM;

period = [1:5 6:2:14];

noAmp = length(amplitude);
noPeriod = length(period);
TqNom = 2.517e+06;

noCase = noAmp*noPeriod+1;
values = cell(noCase,1);
names = cell(noCase,1);

%% Run reference case
xxsimSetParameters('LoadTemp.index', 1);
xxsimSetParameters('LoadTemp.Load_bias', 0.71161*TqNom);

logVariables = {'time' ,...
    'DieselEngine2Stroke.EngineControl.Integrate_fuel.output', ...
    'DieselEngine2Stroke.EngineControl.workShaft.output', ...
    'DieselEngine2Stroke.TurbochargingSystem.pipeBCool1.Thdyn_Cont_Vol_Cyl.p',...
    'Governor.uGov',...
    'ShaftSystem.shaftPower',...
    'ShaftSystem.shaftSpeed',...
    'DieselEngine2Stroke.TurbochargingSystem.Turbocharger1.Shaft.OneJunction.flow'};
xxsimSetLogVariables(logVariables);

xxsimRun();
[values{1}, names{1}] = xxsimGetLogValues(logVariables);

logVariables = {'time' ,...
    'DieselEngine2Stroke.EngineControl.Integrate_fuel.output', ...
    'DieselEngine2Stroke.EngineControl.workShaft.output', ...
    'DieselEngine2Stroke.TurbochargingSystem.pipeBCool1.Thdyn_Cont_Vol_Cyl.p',...
    'Governor.uGov',...
    'ShaftSystem.shaftPower',...
    'ShaftSystem.shaftSpeed',...
    'DieselEngine2Stroke.TurbochargingSystem.Turbocharger1.Shaft.OneJunction.flow',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.F'};
xxsimSetLogVariables(logVariables);

for ii = 1:noAmp
    for j = 1:noPeriod
        caseNo = (ii-1)*noPeriod + j;
        fprintf('Running case %d out of %d\n',caseNo, noCase);        
        xxsimSetParameters('LoadTemp.index', 2);
        xxsimSetParameters('LoadTemp.Load_bias', 0.71161*TqNom);
        xxsimSetParameters('LoadTemp.Load_amp',amplitude(ii)*TqNom);
        xxsimSetParameters('LoadTemp.Start_time', 50);
        xxsimSetParameters('LoadTemp.T_Load',period(j));
        xxsimRun();
        [values{caseNo+1}, names{caseNo+1}] = xxsimGetLogValues(logVariables);
    end;
end;

        
        
        
                    