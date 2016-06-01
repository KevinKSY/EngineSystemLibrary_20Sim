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

%%

logVariables = {'time' ,...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.SFOC.mf',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.SFOC.W',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.QCyl.q',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.CrankMechanism.QSensor4.q_rad',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.p',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.T',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.F',...
    'DieselEngine2Stroke.EngineCylinderBlock.EngCylinder1.Submodel2.Thdyn_Cont_Vol_Cyl.V'}

xxsimSetLogVariables(logVariables);
xxsimSetParameters('DieselEngine2Stroke.BoundaryIn.T',eng_data.condition.ref.T_amb+273.15);    
xxsimSetParameters('tCW',eng_data.condition.ref.T_cw_scav + 273.15);    

values = cell(noCase,1);
names = cell(noCase,1);
for caseNo = 1:noCase
    xxsimSetParameters('ConstantRPMRef.RPMRef', eng_data.perf.RPM(caseNo));
    xxsimRun();
    [values{caseNo}, names{caseNo}] = xxsimGetLogValues(logVariables);
    save('SSNOxResult.mat','values','names');
end;  
%}
%%
