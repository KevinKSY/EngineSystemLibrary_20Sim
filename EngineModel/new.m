xxsimConnect();

fprintf('Choose your model\n');

filename = uigetfile('*.emx');

modelfile = fullfile(pwd,filename);

xxsimOpenModel(modelfile);
xxsimProcessModel();
%% Set Parameters
%% global
%{a
xxsimSetParameters('DieselEngine2Stroke.nCyl', eng.nCyl);
xxsimSetParameters('DieselEngine2Stroke.nStroke', eng.nStroke);
xxsimSetParameters('DieselEngine2Stroke.vDisp', eng.cyl(1).dim.vDisp);
xxsimSetParameters('RPMMax', eng.RPMMax);
xxsimSetParameters('DieselEngine2Stroke.Pe', eng.Pe);

xxsimSetParameters('DieselEngine2Stroke.fs', eng.fs);
xxsimSetParameters('DieselEngine2Stroke.hn', eng.hn);
xxsimSetParameters('DieselEngine2Stroke.kai', eng.cyl(1).gasEx.kai);
xxsimSetParameters('DieselEngine2Stroke.delta', eng.cyl(1).gasEx.delta);
xxsimSetParameters('DieselEngine2Stroke.mqf_max', eng.cyl(1).comb.mqfCycMax);

xxsimSetParameters('DieselEngine2Stroke.wiebe_para', eng.cyl(1).comb.wiebePara);
%}
%% Cylinders
%{A
for i = 1:eng.nCyl;
	paramPrefix = strcat('DieselEngine2Stroke.EngineCylinderBlock.EngCylinder',int2str(i),'.');
	xxsimSetParameters(strcat(paramPrefix,'V0'), eng.cyl(i).init.V0);
	xxsimSetParameters(strcat(paramPrefix,'m0'), eng.cyl(i).init.m0);
	xxsimSetParameters(strcat(paramPrefix,'E0'), eng.cyl(i).init.E0);
	xxsimSetParameters(strcat(paramPrefix,'mb0'), eng.cyl(i).init.mb0);
	xxsimSetParameters(strcat(paramPrefix,'p0'), eng.cyl(i).init.p0);
	xxsimSetParameters(strcat(paramPrefix,'T0'), eng.cyl(i).init.T0);
	xxsimSetParameters(strcat(paramPrefix,'F0'), eng.cyl(i).init.F0);
	xxsimSetParameters(strcat(paramPrefix,'B'), eng.cyl(i).dim.B);
	xxsimSetParameters(strcat(paramPrefix,'betaExh'), eng.cyl(i).exhVVDim.beta);
	xxsimSetParameters(strcat(paramPrefix,'CAIPO'), eng.cyl(i).scavPort.cASPO);
	xxsimSetParameters(strcat(paramPrefix,'coeff_alpha'), eng.cyl(i).HT.cAlpha);
	xxsimSetParameters(strcat(paramPrefix,'CR'), eng.cyl(i).dim.CR);
	xxsimSetParameters(strcat(paramPrefix,'C_cylHT'), eng.cyl(i).HT.cCylHT);
	xxsimSetParameters(strcat(paramPrefix,'DpExh'), eng.cyl(i).exhVVDim.Dp);
	xxsimSetParameters(strcat(paramPrefix,'DsExh'), eng.cyl(i).exhVVDim.Ds);
	xxsimSetParameters(strcat(paramPrefix,'DvExh'), eng.cyl(i).exhVVDim.Dv);
	xxsimSetParameters(strcat(paramPrefix,'ExhCA_start_ref'), eng.cyl(i).exhVVProf.cAStartRef);
	xxsimSetParameters(strcat(paramPrefix,'ExhdCA_lift_down'), eng.cyl(i).exhVVProf.dCALiftDown);
	xxsimSetParameters(strcat(paramPrefix,'ExhdCA_lift_top_ref'), eng.cyl(i).exhVVProf.dCALiftTopRef);
	xxsimSetParameters(strcat(paramPrefix,'ExhdCA_lift_up'), eng.cyl(i).exhVVProf.dCALiftUp);
	xxsimSetParameters(strcat(paramPrefix,'ExhLift_max'), eng.cyl(i).exhVVDim.liftMax);
	xxsimSetParameters(strcat(paramPrefix,'ExhVVProfDownX'), eng.cyl(i).exhVVProf.cAVVDownRef);
	xxsimSetParameters(strcat(paramPrefix,'ExhVVProfDownY'), eng.cyl(i).exhVVProf.liftDownRef);
	xxsimSetParameters(strcat(paramPrefix,'ExhVVProfUpX'), eng.cyl(i).exhVVProf.cAVVUpRef);
	xxsimSetParameters(strcat(paramPrefix,'ExhVVProfUpY'), eng.cyl(i).exhVVProf.liftUpRef);
	xxsimSetParameters(strcat(paramPrefix,'lambdaR'), eng.cyl(i).dim.lambda);
	xxsimSetParameters(strcat(paramPrefix,'mCp'), eng.cyl(i).HT.mCp);
	xxsimSetParameters(strcat(paramPrefix,'N_p'), eng.cyl(i).scavPort.nPort);
	xxsimSetParameters(strcat(paramPrefix,'phi0'), eng.cyl(i).init.phi0);
	xxsimSetParameters(strcat(paramPrefix,'S'), eng.cyl(i).dim.S);
	xxsimSetParameters(strcat(paramPrefix,'T_w_init'), eng.cyl(i).HT.tempWall0);
	xxsimSetParameters(strcat(paramPrefix,'vDisp'), eng.cyl(i).dim.vDisp);
	xxsimSetParameters(strcat(paramPrefix,'wExh'), eng.cyl(i).exhVVDim.w);
	xxsimSetParameters(strcat(paramPrefix,'X'), eng.cyl(i).scavPort.X);
	xxsimSetParameters(strcat(paramPrefix,'Y'), eng.cyl(i).scavPort.Y);
end;
%}
%% InitialValues
%{a
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.m0',eng.scavRec.m0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.E0',eng.scavRec.E0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.mb0',eng.scavRec.mb0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.V0',eng.scavRec.V0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.p0',eng.scavRec.p0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.T0',eng.scavRec.T0);
    xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.F0',eng.scavRec.F0);

    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.m0',eng.exhRec.m0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.E0',eng.exhRec.E0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.mb0',eng.exhRec.mb0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.V0',eng.exhRec.V0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.p0',eng.exhRec.p0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.T0',eng.exhRec.T0);
    xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.F0',eng.exhRec.F0);
%}

%% TurbochargingSystem
%{A
for i = 1:2
    % # Turbocharger
    paramPrefix = strcat('DieselEngine2Stroke.TurbochargingSystem.Turbocharger',int2str(i),'.');
    xxsimSetParameters(strcat(paramPrefix,'omegat0'), eng.turbo.omegaT0);
    xxsimSetParameters(strcat(paramPrefix,'i'), eng.turbo.jTC);
    xxsimSetParameters(strcat(paramPrefix,'r'), [0;0;0]);
    %{
    xxsimSetParameters('DieselEngine2Stroke.Turbocharger1.effMapComp', eng.turbo.comp.effMap);
    xxsimSetParameters('DieselEngine2Stroke.Turbocharger1.flowMapComp', eng.turbo.comp.flowMap);
    xxsimSetParameters('DieselEngine2Stroke.Turbocharger1.nGrid', eng.turbo.comp.npr);
    xxsimSetParameters('DieselEngine2Stroke.Turbocharger1.prRefComp', eng.turbo.comp.prRep);
    xxsimSetParameters('DieselEngine2Stroke.Turbocharger1.spRefComp', eng.turbo.comp.n298Rep);
    %}
    xxsimSetParameters(strcat(paramPrefix,'flow_coeff_turb'), eng.turbo.turb.flowCoeff);
    xxsimSetParameters(strcat(paramPrefix,'eff_coeff_turb'), eng.turbo.turb.effCoeff);
    
    % # Scavenge air cooler
    paramPrefix = strcat('DieselEngine2Stroke.TurbochargingSystem.ScavengeAirCooler',int2str(i),'.');
    xxsimSetParameters(strcat(paramPrefix,'A_air_path'), eng.cAC.areaAirPath);
    xxsimSetParameters(strcat(paramPrefix,'Cd'), eng.cAC.Cd);
    xxsimSetParameters(strcat(paramPrefix,'coeff_T_cw_K'), eng.cAC.coeffTCWK);
    xxsimSetParameters(strcat(paramPrefix,'Cp_cw'), eng.cAC.CpCW);
    xxsimSetParameters(strcat(paramPrefix,'dm_cw'), eng.cAC.dmCW);
    xxsimSetParameters(strcat(paramPrefix,'D_cw_pipe'), eng.cAC.dCWPipe);

    % # Blower
    paramPrefix = strcat('DieselEngine2Stroke.TurbochargingSystem.Blower',int2str(i),'.');
    xxsimSetParameters(strcat(paramPrefix,'eta_blower'),eng.blower.effBlower);
    xxsimSetParameters(strcat(paramPrefix,'coeff_blower_flow'),eng.blower.coeffBlowerFlow); 

    % # Control volumes
    paramPrefix = strcat('DieselEngine2Stroke.TurbochargingSystem.pipeBCool',int2str(i),'.');
    xxsimSetParameters(strcat(paramPrefix,'p0'),eng.pipeBCool.p0);
    xxsimSetParameters(strcat(paramPrefix,'T0'),eng.pipeBCool.T0);
    xxsimSetParameters(strcat(paramPrefix,'F0'),eng.pipeBCool.F0);
    xxsimSetParameters(strcat(paramPrefix,'m0'),eng.pipeBCool.m0);
    xxsimSetParameters(strcat(paramPrefix,'E0'),eng.pipeBCool.E0);
    xxsimSetParameters(strcat(paramPrefix,'mb0'),eng.pipeBCool.mb0);
    xxsimSetParameters(strcat(paramPrefix,'V0'),eng.pipeBCool.V0);
end;
% # WasteGate
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.BW1',eng.control.WG.LPBWdmExh);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.BW2',eng.control.WG.LPBWdmExhBypass);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.K',eng.control.WG.Kp);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.Ti',eng.control.WG.Ti);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.minimum',eng.control.WG.uMin);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.maximum',eng.control.WG.uMax);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.SP',eng.control.WG.Ratio);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.p_ref_upper',eng.control.WG.upperOpenSPWG);
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.WasteGate.p_ref_lower',eng.control.WG.lowerCloseSPWG);	

% # Blower controller
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.BlowerControl.SP_upper',eng.control.blower.upper);	
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.BlowerControl.SP_lower',eng.control.blower.lower);	
xxsimSetParameters('DieselEngine2Stroke.TurbochargingSystem.BlowerControl.tau',eng.control.blower.tau);	

%% Control volumes - Receivers
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.p0',eng.scavRec.p0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.T0',eng.scavRec.T0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.F0',eng.scavRec.F0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.m0',eng.scavRec.m0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.E0',eng.scavRec.E0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.mb0',eng.scavRec.mb0);
xxsimSetParameters('DieselEngine2Stroke.ScavReceiver.V0',eng.scavRec.V0);

xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.p0',eng.exhRec.p0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.T0',eng.exhRec.T0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.F0',eng.exhRec.F0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.m0',eng.exhRec.m0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.E0',eng.exhRec.E0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.mb0',eng.exhRec.mb0);
xxsimSetParameters('DieselEngine2Stroke.ExhaustReceiver.V0',eng.exhRec.V0);

%% Shaft System
xxsimSetParameters('DieselEngine2Stroke.ShaftSystem.r',eng.coeffMechEff);
xxsimSetParameters('DieselEngine2Stroke.ShaftSystem.i',eng.jShaft);
xxsimSetParameters('DieselEngine2Stroke.ShaftSystem.RPM0',eng.omegaE0*30/pi);

%% Propeller
%xxsimSetParameters('DieselEngine2Stroke.Propeller.r',coeffProp);
%}
%% Engine Controller
xxsimSetParameters('DieselEngine2Stroke.EngineControl.dmf_LowPassFilter.y_initial', eng.BSFC0*eng.Pe*eng.engLoad0/3.6e9);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.dmf_LowPassFilter.BW', eng.control.dmfLP.BW);

xxsimSetParameters('DieselEngine2Stroke.EngineControl.P_LowPassFilter.y_initial', eng.Pe*eng.engLoad0);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.P_LowPassFilter.BW', eng.control.powLP.BW);

xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.LowPassFilter.y_initial', eng.omegaE0);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.RPMCommanTF.state_initial', eng.omegaE0*30/pi);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.BW', eng.control.gov.LPBW);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.K', eng.control.gov.Kp);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.maximum', eng.control.gov.uMax);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.minimum', eng.control.gov.uMin);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.N', eng.control.gov.N);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.Ta', 1/eng.control.gov.Kb);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.Td', eng.control.gov.Td);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.Ti', eng.control.gov.Ti);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.Governor.output_initial', eng.control.gov.u0);

xxsimSetParameters('DieselEngine2Stroke.EngineControl.SmokeLimiter.LowPassFilter.y_initial', eng.scavRec.p0);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.SmokeLimiter.LowPassFilter1.y_initial', eng.scavRec.T0);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.SmokeLimiter.BW1', eng.control.smokeLim.LPBW);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.SmokeLimiter.BW2', eng.control.smokeLim.LPBW);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.SmokeLimiter.FMax', eng.control.smokeLim.FMax);

xxsimSetParameters('DieselEngine2Stroke.EngineControl.EngineControl.exh_VV_dur_ref', eng.control.EVC.EVCyRef);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.EngineControl.exh_VV_start', eng.control.EVO);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.EngineControl.fiinj_ref', eng.control.inj.phiInjyRef);
xxsimSetParameters('DieselEngine2Stroke.EngineControl.EngineControl.speedRef', eng.control.inj.phiInjxRef);
%}



fprintf('Inspect your model before saving it.\n');
pause();
uin = '';

while ~strcmp(uin,'y') || ~strcmp(uin,'n')

    uin = input('Save?','s');

end;

if strcmp(uin,'y')

    xxsimSaveModel();

end;

uin = '';

while ~strcmp(uin,'y') || ~strcmp(uin,'n')

    uin = input('Close th model?','s');

end;

if strcmp(uin,'y')

    xxsimCloseModel();

end;

% disconnect from 20-sim

xxsimDisconnect();

