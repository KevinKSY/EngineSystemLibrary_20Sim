clear

EngineSystemParameters_ScaniaD12;
%%
mdl = 'C:\Users\yum\Desktop\4strokeCyl.emx';

xxsimConnect();
xxsimOpenModel(mdl);
xxsimProcessModel();
simTime = 50;

xxsimSetParameters('Eng_Cyl1\S',eng.cyl.dim.S);
xxsimSetParameters('Eng_Cyl1\lambdaR',eng.cyl.dim.lambda);
xxsimSetParameters('Eng_Cyl1\B',eng.cyl.dim.B);
xxsimSetParameters('Eng_Cyl1\CR',eng.cyl.dim.CR);
xxsimSetParameters('Eng_Cyl1\vDisp',pi*eng.cyl.dim.B^2/4*eng.cyl.dim.S);

xxsimSetParameters('Eng_Cyl1\ExhProfNoRow1',length(eng.cyl.exhVVProf.liftUpRef));
xxsimSetParameters('Eng_Cyl1\ExhProfNoRow2',length(eng.cyl.exhVVProf.liftDownRef));
xxsimSetParameters('Eng_Cyl1\ExhVVProfUp',eng.cyl.exhVVProf.liftUpRef);
xxsimSetParameters('Eng_Cyl1\ExhVVProfDown',eng.cyl.exhVVProf.liftDownRef);
xxsimSetParameters('Eng_Cyl1\ExhLift_max',eng.cyl.exhVVDim.liftMax);
xxsimSetParameters('Eng_Cyl1\ExhCA_start_ref',eng.cyl.exhVVProf.cAStartRef);
xxsimSetParameters('Eng_Cyl1\ExhdCA_lift_up',eng.cyl.exhVVProf.dCALiftUp);
xxsimSetParameters('Eng_Cyl1\ExhdCA_lift_down',eng.cyl.exhVVProf.dCALiftDown);
xxsimSetParameters('Eng_Cyl1\noExhVV',eng.cyl.exhVVDim.no);
xxsimSetParameters('Eng_Cyl1\DvExh',eng.cyl.exhVVDim.Dv);
xxsimSetParameters('Eng_Cyl1\betaExh',eng.cyl.exhVVDim.beta);
xxsimSetParameters('Eng_Cyl1\wExh',eng.cyl.exhVVDim.w);
xxsimSetParameters('Eng_Cyl1\DpExh',eng.cyl.exhVVDim.Dp);
xxsimSetParameters('Eng_Cyl1\DsExh',eng.cyl.exhVVDim.Ds);

xxsimSetParameters('Eng_Cyl1\InProfNoRow1',length(eng.cyl.intakeVVProf.liftUpRef));
xxsimSetParameters('Eng_Cyl1\InProfNoRow2',length(eng.cyl.intakeVVProf.liftDownRef));
xxsimSetParameters('Eng_Cyl1\InVVProfUp',eng.cyl.intakeVVProf.liftUpRef);
xxsimSetParameters('Eng_Cyl1\InVVProfDown',eng.cyl.intakeVVProf.liftDownRef);
xxsimSetParameters('Eng_Cyl1\InLift_max',eng.cyl.exhVVDim.liftMax);
xxsimSetParameters('Eng_Cyl1\InCA_start_ref',eng.cyl.intakeVVProf.cAStartRef);
xxsimSetParameters('Eng_Cyl1\IndCA_lift_up',eng.cyl.intakeVVProf.dCALiftUp);
xxsimSetParameters('Eng_Cyl1\IndCA_lift_down',eng.cyl.intakeVVProf.dCALiftDown);
xxsimSetParameters('Eng_Cyl1\noInVV',eng.cyl.intakeVVDim.no);
xxsimSetParameters('Eng_Cyl1\DvIntake',eng.cyl.intakeVVDim.Dv);
xxsimSetParameters('Eng_Cyl1\betaIntake',eng.cyl.intakeVVDim.beta);
xxsimSetParameters('Eng_Cyl1\wIntake',eng.cyl.intakeVVDim.w);
xxsimSetParameters('Eng_Cyl1\DpIntake',eng.cyl.intakeVVDim.Dp);
xxsimSetParameters('Eng_Cyl1\DsIntake',eng.cyl.intakeVVDim.Ds);
% Heat transfer model
xxsimSetParameters('Eng_Cyl1\T_w_init',eng.cyl.HT.tempWall0);
% Initial values
xxsimSetParameters('Eng_Cyl1\m0',eng.cyl.init.m0);
xxsimSetParameters('Eng_Cyl1\E0',eng.cyl.init.E0);
xxsimSetParameters('Eng_Cyl1\mb0',eng.cyl.init.mb0);
xxsimSetParameters('Eng_Cyl1\p0',eng.cyl.init.p0);
xxsimSetParameters('Eng_Cyl1\T0',eng.cyl.init.T0);
xxsimSetParameters('Eng_Cyl1\F0',eng.cyl.init.F0);
xxsimSetParameters('Eng_Cyl1\V0',eng.cyl.init.V0);
xxsimSetParameters('Eng_Cyl1\phi0',eng.cyl.init.phi0);