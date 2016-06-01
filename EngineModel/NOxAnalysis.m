load('SSNOxResult_Scania')
%load('SSNOxResult');
close all
sNOxCase = zeros(length(values),1);
cNOxCase = zeros(length(values),1);
TuCalc = cell(length(values),1);
TbCalc = TuCalc;
vuCalc = TuCalc;
vbCalc = TuCalc;
FuCalc = TuCalc;
FbCalc = TuCalc;
pCylCyc = TuCalc;
TCylCyc = TuCalc;
FCylCyc = TuCalc;
phiCombCylCyc = TuCalc;
nStroke = 4;
tic
for i = 2:length(values)
    timeSim = values{i}(end-20000:end,1);
    mfCyl = values{i}(end-20000:end,2);
    WCyl = values{i}(end-20000:end,3);
    QCyl = values{i}(end-20000:end,4);
    phiCyl = values{i}(end-20000:end,5);
    pCyl = values{i}(end-20000:end,6);
    TCyl = values{i}(end-20000:end,7);
    FCyl = values{i}(end-20000:end,8);
    vCyl = values{i}(end-20000:end,9);
    [sNOxCalc, cNOxCalc, TuCalc{i}, TbCalc{i}, vuCalc{i}, vbCalc{i}, FuCalc{i}, FbCalc{i}, pCylCyc{i}, TCylCyc{i}, FCylCyc{i}, phiCombCylCyc{i}] = NOxPostProcessNew(timeSim,phiCyl,pCyl,TCyl,FCyl,vCyl,mfCyl,QCyl,WCyl,nStroke,0.8,[],[],[],[],[]);
    sNOxCase(i) = mean(sNOxCalc(end-10000:end));
    cNOxCase(i) = mean(cNOxCalc(end-10000:end));
    save('SSNOxAnalysisScaniaFComb08.mat','sNOxCase','cNOxCase','TuCalc', 'TbCalc', 'vuCalc', 'vbCalc', 'FuCalc', 'FbCalc', 'pCylCyc', 'TCylCyc', 'FCylCyc', 'phiCombCylCyc');
end;
toc
