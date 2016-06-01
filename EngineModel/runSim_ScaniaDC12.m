clear
% 
EngineSystemParameters_ScaniaD12;
%%
mdl = 'ScaniaDC12.emx';

xxsimConnect();
xxsimOpenModel(mdl);
xxsimProcessModel();
simTime = 100;
% %% Parameter setting - Do it only when necessary
% %{
% 
% for i = 1:eng.nCyl
%     cylName = ['EngCylBlock4Stroke\Eng_Cyl' int2str(i)];
% %{    
%     xxsimSetParameters([cylName '\S'],eng.cyl(i).dim.S);
%     xxsimSetParameters([cylName '\lambdaR'],eng.cyl(i).dim.lambda);
%     xxsimSetParameters([cylName '\B'],eng.cyl(i).dim.B);
%     xxsimSetParameters([cylName '\CR'],eng.cyl(i).dim.CR);
%     xxsimSetParameters([cylName '\vDisp'],pi*eng.cyl(i).dim.B^2/4*eng.cyl(i).dim.S);
% 
%     xxsimSetParameters([cylName '\ExhProfNoRow1'],length(eng.cyl(i).exhVVProf.liftUpRef));
%     xxsimSetParameters([cylName '\ExhProfNoRow2'],length(eng.cyl(i).exhVVProf.liftDownRef));
%     xxsimSetParameters([cylName '\ExhVVProfUp'],eng.cyl(i).exhVVProf.liftUpRef);
%     xxsimSetParameters([cylName '\ExhVVProfDown'],eng.cyl(i).exhVVProf.liftDownRef);
%     xxsimSetParameters([cylName '\ExhLift_max'],eng.cyl(i).exhVVDim.liftMax);
%     xxsimSetParameters([cylName '\ExhCA_start_ref'],eng.cyl(i).exhVVProf.cAStartRef);
%     xxsimSetParameters([cylName '\ExhdCA_lift_up'],eng.cyl(i).exhVVProf.dCALiftUp);
%     xxsimSetParameters([cylName '\ExhdCA_lift_down'],eng.cyl(i).exhVVProf.dCALiftDown);
%     xxsimSetParameters([cylName '\noExhVV'],eng.cyl(i).exhVVDim.no);
%     xxsimSetParameters([cylName '\DvExh'],eng.cyl(i).exhVVDim.Dv);
%     xxsimSetParameters([cylName '\betaExh'],eng.cyl(i).exhVVDim.beta);
%     xxsimSetParameters([cylName '\wExh'],eng.cyl(i).exhVVDim.w);
%     xxsimSetParameters([cylName '\DpExh'],eng.cyl(i).exhVVDim.Dp);
%     xxsimSetParameters([cylName '\DsExh'],eng.cyl(i).exhVVDim.Ds);
% 
%     xxsimSetParameters([cylName '\InProfNoRow1'],length(eng.cyl(i).intakeVVProf.liftUpRef));
%     xxsimSetParameters([cylName '\InProfNoRow2'],length(eng.cyl(i).intakeVVProf.liftDownRef));
%     xxsimSetParameters([cylName '\InVVProfUp'],eng.cyl(i).intakeVVProf.liftUpRef);
%     xxsimSetParameters([cylName '\InVVProfDown'],eng.cyl(i).intakeVVProf.liftDownRef);
%     xxsimSetParameters([cylName '\InLift_max'],eng.cyl(i).exhVVDim.liftMax);
%     xxsimSetParameters([cylName '\InCA_start_ref'],eng.cyl(i).intakeVVProf.cAStartRef);
%     xxsimSetParameters([cylName '\IndCA_lift_up'],eng.cyl(i).intakeVVProf.dCALiftUp);
%     xxsimSetParameters([cylName '\IndCA_lift_down'],eng.cyl(i).intakeVVProf.dCALiftDown);
%     xxsimSetParameters([cylName '\noInVV'],eng.cyl(i).intakeVVDim.no);
%     xxsimSetParameters([cylName '\DvIntake'],eng.cyl(i).intakeVVDim.Dv);
%     xxsimSetParameters([cylName '\betaIntake'],eng.cyl(i).intakeVVDim.beta);
%     xxsimSetParameters([cylName '\wIntake'],eng.cyl(i).intakeVVDim.w);
%     xxsimSetParameters([cylName '\DpIntake'],eng.cyl(i).intakeVVDim.Dp);
%     xxsimSetParameters([cylName '\DsIntake'],eng.cyl(i).intakeVVDim.Ds);
% %}    
%     % Heat transfer model
%     xxsimSetParameters([cylName '\T_w_init'],eng.cyl(i).HT.tempWall0);
%     xxsimSetParameters([cylName '\coeff_alpha'],eng.cyl(i).HT.cAlpha);
%     % Initial values
% %{    
%     xxsimSetParameters([cylName '\m0'],eng.cyl(i).init.m0);
%     xxsimSetParameters([cylName '\E0'],eng.cyl(i).init.E0);
%     xxsimSetParameters([cylName '\mb0'],eng.cyl(i).init.mb0);
%     xxsimSetParameters([cylName '\p0'],eng.cyl(i).init.p0);
%     xxsimSetParameters([cylName '\T0'],eng.cyl(i).init.T0);
%     xxsimSetParameters([cylName '\F0'],eng.cyl(i).init.F0);
%     xxsimSetParameters([cylName '\V0'],eng.cyl(i).init.V0);
%     xxsimSetParameters([cylName '\phi0'],eng.cyl(i).init.phi0);
% %}    
% end;
% %%
% 
% xxsimSetParameters('ChargeAirReciever\p0',eng.CARec.p0);
% xxsimSetParameters('ChargeAirReciever\T0',eng.CARec.T0);
% xxsimSetParameters('ChargeAirReciever\F0',eng.CARec.F0);
% xxsimSetParameters('ChargeAirReciever\V0',eng.CARec.V0);
% xxsimSetParameters('ChargeAirReciever\m0',eng.CARec.m0);
% xxsimSetParameters('ChargeAirReciever\E0',eng.CARec.E0);
% xxsimSetParameters('ChargeAirReciever\mb0',eng.CARec.mb0);
% 
% xxsimSetParameters('ExhaustReceiver\p0',eng.exhRec.p0);
% xxsimSetParameters('ExhaustReceiver\T0',eng.exhRec.T0);
% xxsimSetParameters('ExhaustReceiver\F0',eng.exhRec.F0);
% xxsimSetParameters('ExhaustReceiver\V0',eng.exhRec.V0);
% xxsimSetParameters('ExhaustReceiver\m0',eng.exhRec.m0);
% xxsimSetParameters('ExhaustReceiver\E0',eng.exhRec.E0);
% xxsimSetParameters('ExhaustReceiver\mb0',eng.exhRec.mb0);
% 
% xxsimSetParameters('pipeBCool\p0',eng.pipeBCool.p0);
% xxsimSetParameters('pipeBCool\T0',eng.pipeBCool.T0);
% xxsimSetParameters('pipeBCool\F0',eng.pipeBCool.F0);
% xxsimSetParameters('pipeBCool\V0',eng.pipeBCool.V0);
% xxsimSetParameters('pipeBCool\m0',eng.pipeBCool.m0);
% xxsimSetParameters('pipeBCool\E0',eng.pipeBCool.E0);
% xxsimSetParameters('pipeBCool\mb0',eng.pipeBCool.mb0);
% 
% xxsimSetParameters('Turbocharger1\i',eng.turbo.jTC);
% xxsimSetParameters('Turbocharger1\r',[0;0;0]);
% xxsimSetParameters('Turbocharger1\omegat0',eng.turbo.omega0);
% xxsimSetParameters('Turbocharger1\flow_coeff_turb',eng.turbo.turb.flowCoeff');
% xxsimSetParameters('Turbocharger1\Uc_opt',eng.turbo.turb.ucOpt);
% xxsimSetParameters('Turbocharger1\Dturb_wheel',eng.turbo.turb.dTurbWheel);
% xxsimSetParameters('Turbocharger1\eta_t_max',eng.turbo.turb.effMax);
% xxsimSetParameters('Turbocharger1\tRef',eng.turbo.turb.tempRef);
% 
% xxsimSetParameters('ChargeAirCooler\Cd',eng.cAC.Cd);
% xxsimSetParameters('ChargeAirCooler\A_air_path',eng.cAC.areaAirPath);
% xxsimSetParameters('ChargeAirCooler\dm_cw',eng.cAC.dmCW);
% xxsimSetParameters('ChargeAirCooler\coeff_T_cw_K',eng.cAC.coeffTCWK');
% xxsimSetParameters('ChargeAirCooler\Cp_cw',eng.cAC.CpCW);
% xxsimSetParameters('ChargeAirCooler\D_cw_pipe',eng.cAC.dCWPipe);
% 
% 
% %{
% xxsimSetParameters('pTFER',pTFER);
% xxsimSetParameters('wiebePara',ROHRanal);
% xxsimSetParameters('TqLoad',Tq);
% xxsimSetParameters('RPMRef',RPM);
% xxsimSetParameters('tCWRef',T_cw_bcc);
% xxsimSetParameters('RPMMax',1800);
% xxsimSetParameters('vDisp',eng.cyl(1).dim.vDisp);
% xxsimSetParameters('mqf_max',eng.cyl(1).comb.mqfCycMax);
% %}
% %}
% %{
% 
% 
% xxsimSetParameters('plotTurbocharger\PRSurge',TC.SAE_map_comp.PR_surge);
% xxsimSetParameters('plotTurbocharger\dmSurge',TC.SAE_map_comp.m_dot_surge);
% xxsimSetParameters('plotTurbocharger\PRChock',TC.SAE_map_comp.PR_chock);
% xxsimSetParameters('plotTurbocharger\dmChock',TC.SAE_map_comp.m_dot_chock);
% RPMUniq = unique(TC.SAE_map_comp.RPM);
% for i = 1:length(RPMUniq)
%     idx = find(TC.SAE_map_comp.RPM == RPMUniq(i));
%     xxsimSetParameters(['plotTurbocharger\PR' int2str(i)],TC.SAE_map_comp.PR(idx));
%     xxsimSetParameters(['plotTurbocharger\dm' int2str(i)],TC.SAE_map_comp.m_dot(idx));
% end;
% %}
% 
%% Run simulation
noCases = 1;
 
logVariables = {'time' ,...  // 1
    'EngCylBlock4Stroke.Eng_Cyl1.engCylCV.Thdyn_Cont_Vol_Cyl.p', ... //2
    'EngCylBlock4Stroke.Eng_Cyl1.engCylCV.Thdyn_Cont_Vol_Cyl.T', ... //3
    'EngCylBlock4Stroke.Eng_Cyl1.engCylCV.Thdyn_Cont_Vol_Cyl.F',...//4
    'EngCylBlock4Stroke.Eng_Cyl1.CrankMechanism1.q_rad', ...    //5
    'EngCylBlock4Stroke.Eng_Cyl1.engCylCV.Thdyn_Cont_Vol_Cyl.V'};    %6

%    'EngCylBlock4Stroke.p.T',...  // 2
%    'Controller.LPPower.y',...  // 3 Power low filtered
%    'Controller.MultiplyDivide.output',...    // 4 BSFC
%    'Controller.IntegrateFuel.output',... // 5 Fuel consumed
%    'Controller.IntegrateShaftPower.output',... // 6 Shaft work
%    'Controller.output[4]',... // 7 fuel injection timing
%    'Controller.output[6]',... // 8 EVO
%    'Controller.output[7]',... // 9 EVC
%    'EngCylBlock4Stroke.Eng_Cyl1.CrankMechanism1.QSensor4.q_rad',... // 10 Ca in radian
%    'EngCylBlock4Stroke.Eng_Cyl1.pMaxFinder.phiAtPMax',... // 11
%    'EngCylBlock4Stroke.Eng_Cyl1.pMaxFinder.pMax',... // 12
%    'EngCylBlock4Stroke.Eng_Cyl1.ROHR.dmf',... // 13
%    'EngCylBlock4Stroke.Eng_Cyl1.SFOC.ISFC',... // 14
%    'EngCylBlock4Stroke.Eng_Cyl1.SFOC.IMEP',... // 15
%    'EngCylBlock4Stroke.FMEP.fmep',...// 16
%    'Controller.dQCyl',... // 17
%    'Controller\tWall',... // 18
%    'ExhaustReceiver.Thdyn_Cont_Vol_Cyl.p',... // 19
%    'ExhaustReceiver.Thdyn_Cont_Vol_Cyl.T',... // 20
%    'ExhaustReceiver.Thdyn_Cont_Vol_Cyl.F',... // 21
%    'ChargeAirReciever.Thdyn_Cont_Vol_Cyl.p',... // 22
%    'ChargeAirReciever.Thdyn_Cont_Vol_Cyl.T',... // 23
%    'ChargeAirReciever.Thdyn_Cont_Vol_Cyl.F',... // 24
%    'ChargeAirReciever.Thdyn_Cont_Vol_Cyl.V',... // 25
%    'pipeBCool.Thdyn_Cont_Vol_Cyl.p',... // 26
%    'pipeBCool.Thdyn_Cont_Vol_Cyl.T',... // 27
%    'pipeBCool.Thdyn_Cont_Vol_Cyl.F',... // 28
%    'ChargeAirCooler.Submodel2.T_out',... // 29
%    'Turbocharger1.COMPRES1.etaic',... // 30
%    'Turbocharger1.COMPRES1.dmc',... // 31
%    'Turbocharger1.COMPRES1.momc',... // 32
%    'Turbocharger1.COMPRES1.omegat',... // 33
%    'Turbocharger1.TURBIN1.ded',... // 34
%    'Turbocharger1.TURBIN1.eta_t',... // 35
%    'Turbocharger1.TURBIN1.momt',... // 36
%    'Turbocharger1.TURBIN1.momt',... // 37
%    'Controller.Governor.uGov',... // 38
%    'Controller.Governor.SmokeLimiter.Submodel3.uMax',... // 39
%    'I.p.f',... //40
%    'EngCylBlock4Stroke.LPPower.u',... //41
%    'Controller.LPdhExh.y',... // 42
%    'Controller.LPdQCyl.y',... // 43
%    'Controller.LPdmf.y',... // 44
%    'Controller.LPPower.y',... % 45
%    'Controller.LPfricPow.y'}; % 46

xxsimSetLogVariables(logVariables);

xxsimSaveModel();
%%
%load('C:\Users\yum\Documents\GitHub\EngineSystemLibrary_20Sim\EngineModel\SSNOxResult_Scania.mat'); 
%values = cell(noCases,1);
%for i = 7:noCases
%    i
    %xxsimSetParameters('caseNo', i);
    xxsimRun();
    [values{i}, names] = xxsimGetLogValues(logVariables);
    xxsimClearLastRun();
    save('pTFV.mat','values','names');
%end;

