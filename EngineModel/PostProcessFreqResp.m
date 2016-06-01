
% DOE of parameters
KpMultiplier = [1];
BWMultiplier = [1];
FMaxMultiplier = [1];

dFF = fullfact([1 1 1]);

[noExp,~] = size(dFF);

% Load profile
RPMRef = 80.1;
powRef = 15024000;
amplitude = 0.1:0.1:0.4;
period = [1:5 6:2:14];

noAmp = length(amplitude);
noPeriod = length(period);

% Engine parameters
eng.engLoad0 = 0.6;
EngineSystemParameters8RTFLEX68D;

[b, a] = butter(4,0.05);


%% Reference case

timeSim = values{1}(:,1); 
FuelConRef = values{1}(:,2); 
workShaftRef = values{1}(:,3); 
pScavRef = mean(values{1}(end-5000:end,4));
uGovRef = mean(values{1}(end-5000:end,5));
powRef = mean(values{1}(end-5000:end,6));
omegaERef = mean(values{1}(end-5000:end,7));
omegatRef = mean(values{1}(end-5000:end,8));
idx = find(timeSim >= 50.0);
FuelConsRef = FuelConRef(end) - FuelConRef(idx(1));
WorkShaftRef = workShaftRef(end) - workShaftRef(idx(1));

%% Cases    
    FuelCons = zeros(noAmp,noPeriod);
    WorkShaft = zeros(noAmp,noPeriod);
    omegaECase = zeros(noAmp,noPeriod);
    powCase = zeros(noAmp,noPeriod);
    powAmp = zeros(noAmp,noPeriod);
    powFn = zeros(noAmp,noPeriod);
    omegaEAmp = zeros(noAmp,noPeriod);
    omegaEFn = zeros(noAmp,noPeriod);
    pScavAmp = zeros(noAmp,noPeriod);
    pScavFn = zeros(noAmp,noPeriod);
    uGovAmp = zeros(noAmp,noPeriod);
    uGovFn = zeros(noAmp,noPeriod);
    omegaTAmp = zeros(noAmp,noPeriod);
    omegaTFn = zeros(noAmp,noPeriod);
    simFail = ones(noAmp,noPeriod);    
    FCylMax = ones(noAmp,noPeriod);    
    
    for i = 1:noAmp
        for j = 1:noPeriod
            k = (i-1)*10 + j;
            caseName = num2str(k);
            fprintf('Running case %d out of %d\n',k,(noAmp)*noPeriod); 
            fprintf('Amplitude\t Period\t : %2.1f\t %2.1f\n',amplitude(i),period(j));
            
            timeSim = values{k+1}(:,1);
            if timeSim(end) < 200
                simFail(i,j) = 0;
            end;
            %phiCyl = log.engineSim8Cyl2TCTransien0.5222t.EngineCylinderBlock.EngCylinder1.phi.Data;
            omegaETS= values{k+1}(:,7);
            figure(1);
            plot(timeSim,omegaETS/omegaERef);
            omegaEFil = timeseries(filter(b,a,omegaETS/omegaERef),timeSim);
            hold on
            plot(omegaEFil);
            Data = omegaEFil.Data;
            timeSim = omegaEFil.Time;
            [pksMax idxMax]  = findpeaks(Data);
            [pksMin idxMin] = findpeaks(-Data);
            pksMin = -pksMin;
            plot(timeSim(idxMax),pksMax,'*');
            plot(timeSim(idxMin),pksMin,'o');
            %hold off
            amp = mean(pksMax(end-3:end) - pksMin(end-3:end));
            fn = mean(timeSim(idxMax(end-3:end)) - timeSim(idxMax(end-4:end-1)));
            omegaEAmp(i,j) = amp;
            omegaEFn(i,j) = fn;
            ylim([1-3*amp 1+3*amp])
            xlim([150 200])
            
            omegaECase(i,j) = mean(omegaETS(end-5000:end));
            if abs(omegaECase(i,j) - RPMRef/30*pi) > 0.1*(RPMRef/30*pi)
                simFail(i,j) = 2*simFail(i,j);
            end;
            FCyl = values{k+1}(:,9);
            %mfCyl = log.engineSim8Cyl2TCTransient.EngineCylinderBlock.mfCyl1.Data;
            %QCyl = log.engineSim8Cyl2TCTransient.EngineCylinderBlock.QCyl1.Data;
            %WCyl = log.engineSim8Cyl2TCTransient.EngineCylinderBlock.wCyl1KWH.Data;
            %dmfTot = log.engineSim8Cyl2TCTransient.EngineCylinderBlock.dmfTot.Data;
            pow = values{k+1}(:,6);
            figure(2)
            plot(timeSim,pow/powRef);
            powFil = timeseries(filter(b,a,pow/powRef),timeSim);
            hold on
            plot(powFil);
            Data = powFil.Data;
            %timeSim = powFil.Time;
            [pksMax idxMax]  = findpeaks(Data);
            [pksMin idxMin] = findpeaks(-Data);
            pksMin = -pksMin;
            plot(timeSim(idxMax),pksMax,'*');
            plot(timeSim(idxMin),pksMin,'o');
            %hold off
            amp = mean(pksMax(end-3:end) - pksMin(end-3:end));
            fn = mean(timeSim(idxMax(end-3:end)) - timeSim(idxMax(end-4:end-1)));
            powAmp(i,j) = amp;
            powTs(i,j) = fn;
            ylim([1-3*amp 1+3*amp])
            xlim([150 200])
            
            powCase(i,j) = mean(pow(end-5000:end));
            if abs(powCase(i,j) - powRef) > 0.1*(powRef)
                simFail(i,j) = 3*simFail(i,j);
            end;
            FuelCon = values{k+1}(:,2);
            workShaft = values{k+1}(:,3);
            idx = find(timeSim >= 100);
            if simFail(i,j) 
                FuelCons(i,j) = FuelCon(end) - FuelCon(idx(1));
                WorkShaft(i,j) = workShaft(end) - workShaft(idx(1));
            else
                FuelCons(i,j) = 0;
                WorkShaft(i,j) = 1e-6;
            end;
            %{
            figure(3)
            pScav = timeseries(,timeSim);
            plot(pScav.Time,pScav.Data/pScavRef);
            pScavFil = timeseries(filter(b,a,pScav.Data/pScavRef),timeSim);
            hold on
            plot(pScavFil);
            Data = pScavFil.Data;
            timeSim = pScavFil.Time;
            [pksMax idxMax]  = findpeaks(Data);
            [pksMin idxMin] = findpeaks(-Data);
            pksMin = -pksMin;
            plot(timeSim(idxMax),pksMax,'*');
            plot(timeSim(idxMin),pksMin,'o');
            hold off
            amp = mean(pksMax(end-3:end) - pksMin(end-3:end));
            fn = mean(timeSim(idxMax(end-3:end)) - timeSim(idxMax(end-4:end-1)));
            pScavAmp(i,j) = amp;
            pScavTs(i,j) = fn;
            ylim([1-3*amp 1+3*amp])
            xlim([150 200])
            %}
            %{
            figure(4)
            uGov = logsout.get('uGov').Values;
            plot(uGov.Time,uGov.Data/uGovRef);
            hold on
            Data = uGov.Data/uGovRef;
            timeSim = uGov.Time;
            [pksMax idxMax]  = findpeaks(Data);
            [pksMin idxMin] = findpeaks(-Data);
            pksMin = -pksMin;
            plot(timeSim(idxMax),pksMax,'*');
            plot(timeSim(idxMin),pksMin,'o');
            hold off
            amp = mean(pksMax(end-3:end) - pksMin(end-3:end));
            fn = mean(timeSim(idxMax(end-3:end)) - timeSim(idxMax(end-4:end-1)));
            uGovAmp(i,j) = amp;
            uGovTs(i,j) = fn;
            ylim([1-3*amp 1+3*amp])
            xlim([150 200])
            
            figure(5)
            omegaT = logsout.get('omegat').Values;
            plot(omegaT.Time,omegaT.Data/omegatRef);
            omegaTFil = timeseries(filter(b,a,omegaT.Data/omegatRef),timeSim);
            hold on
            plot(omegaTFil);
            Data = omegaTFil.Data;
            timeSim = omegaTFil.Time;
            [pksMax idxMax]  = findpeaks(Data);
            [pksMin idxMin] = findpeaks(-Data);
            pksMin = -pksMin;
            plot(timeSim(idxMax),pksMax,'*');
            plot(timeSim(idxMin),pksMin,'o');
            hold off
            amp = mean(pksMax(end-3:end) - pksMin(end-3:end));
            fn = mean(timeSim(idxMax(end-3:end)) - timeSim(idxMax(end-4:end-1)));
            omegaTAmp(i,j) = amp;
            omegaTTs(i,j) = fn;
            ylim([1-3*amp 1+3*amp])
            xlim([150 200])

            figure(6)
            subplot(2,1,1)
            bar([omegaEAmp(i,j) powAmp(i,j) pScavAmp(i,j) uGovAmp(i,j) omegaTAmp(i,j) FuelCons(i,j)*WorkShaftRef/FuelConsRef/WorkShaft(i,j)-1]);
            subplot(2,1,2)
            bar([omegaETs(i,j) powTs(i,j) pScavTs(i,j) uGovTs(i,j) omegaTTs(i,j)]);
            
            figure(7)
            idx = timeSim > 100;
            [FCylMax(i,j) idx] = max(FCyl(idx));
            plot(timeSim,FCyl);
            hold on
            plot(timeSim(idx+1e5),FCylMax(i,j),'*');
            hold off
            
            switch simFail(i,j)
                case 0
                    fprintf('Engine stopped!\n');
                case 1
                    fprintf('Good! \n');
                case 2
                    fprintf('Speed reduced!\n');
                case 3
                    fprintf('Power reduced!\n');
                case 6
                    fprintf('Power & Speed reduced!\n');
            end;
%{         a           
            if simFail(i,j) == 1   
                goodness = abs([omegaETs(i,j) powTs(i,j) pScavTs(i,j) uGovTs(i,j) omegaTTs(i,j)] - period(j))/period(j);
                if sum(goodness < 0.05) < 5
                    ANS = '';
                    if ~(strcmp(ANS,'y')||strcmp(ANS,'n'))
                        ANS = input('good(y/n)?','s');
                    end;
                    if (strcmp(ANS,'n'))
                        ANS = 'y';
                        while strcmp(ANS,'y')
                            ANS = 0;
                            while ~(ANS==1||ANS==2||ANS==3||ANS==4||ANS==5)
                                ANS = input('Which output do you want to modify\n (1)Engine speed (2)Power (3) Scav. pressure (4)uGov (5)Turbo speed? (1/2/3/4/5)');
                            end;
                            switch ANS
                                case 1
                                    ANS = input('Amp?');
                                    omegaEAmp(i,j) = ANS;
                                    ANS = input('Period?');
                                    omegaETs(i,j) = ANS;
                                case 2
                                    ANS = input('Amp?');
                                    powAmp(i,j) = ANS;
                                    ANS = input('Period?');
                                    powTs(i,j) = ANS;
                                case 3
                                    ANS = input('Amp?');
                                    pScavAmp(i,j) = ANS;
                                    ANS = input('Period?');
                                    pScavTs(i,j) = ANS;
                                case 4
                                    ANS = input('Amp?');
                                    uGovAmp(i,j) = ANS;
                                    ANS = input('Period?');
                                    uGovTs(i,j) = ANS; 
                                case 5
                                    ANS = input('Amp?');
                                    omegaTAmp(i,j) = ANS;
                                    ANS = input('Period?');
                                    omegaTTs(i,j) = ANS;
                            end;
                            if ~(strcmp(ANS,'y')||strcmp(ANS,'n'))
                                ANS = input('Any other(y/n)?','s');
                            end;
                        end;
                    end;
                end;
            else
                omegaEAmp(i,j) = 0;
                omegaETs(i,j) = 0;
                powAmp(i,j) = 0;
                powTs(i,j) = 0;
                pScavAmp(i,j) = 0;
                pScavTs(i,j) = 0;
                uGovAmp(i,j) = 0;
                uGovTs(i,j) = 0;
                omegaTAmp(i,j) = 0;
                omegaTTs(i,j) = 0;
            end;
            figure(6)
            subplot(2,1,1)
            bar([omegaEAmp(i,j) powAmp(i,j) pScavAmp(i,j) uGovAmp(i,j) omegaTAmp(i,j) FuelCons(i,j)*WorkShaftRef/FuelConsRef/WorkShaft(i,j)-1]);
            subplot(2,1,2)
            bar([omegaETs(i,j) powTs(i,j) pScavTs(i,j) uGovTs(i,j) omegaTTs(i,j)]);
            %}
        end;
    end;        
    %%

    SFOCRef = FuelConsRef*1e9/(WorkShaftRef/3.6);
    SFOC = FuelCons.*1e9./(WorkShaft/3.6);
    SFOCDevRel = (SFOC - SFOCRef)./SFOCRef;
    SFOCDevRel(SFOC == 0) = 0;
    %SNOxRef = NOxRef / (WorkShaftRef/3.6/8);
    %SNOx = NOx ./ (WorkShaft/3.6/8);
    %SNOxDevRel = (SNOx - SNOxRef)./SNOxRef;
    SFOCDevRel = [zeros(1,noPeriod);SFOCDevRel];
    SFOCDevRel = [zeros(noAmp + 1,1) SFOCDevRel];
    %SNOxDevRel = [zeros(1,noPeriod);SNOxDevRel];
    %SNOxDevRel = [zeros(noAmp,1) SNOxDevRel];

    [X, Y] = meshgrid([0 period], [0 amplitude]);
    figure
    surf(X,Y,SFOCDevRel);
    %figure
    %surf(X,Y,SNOxDevRel);
    %figure
    %contour(X,Y,SFOCDevRel);
    drawnow

    save('result.mat','SFOCDevRel','simFail','omegaEAmp','powAmp', ...
        'powTs','omegaETs','pScavAmp','pScavTs','uGovAmp','uGovTs', ...
        'omegaTAmp','omegaTTs','FCylMax');


%}
%% post-post-processing
%{
for i=1:27
    pathName = strcat('C:\Temp\FreqRespResult',num2str(i));
    fileName1 = strcat('result.mat');
    fileName2 = strcat('result',num2str(i),'.mat');
    cd(pathName);
    load(fileName1);
    %load(fileName2);
    %
    movefile(fileName1,fileName2);
%    save(fileName1,'SFOCDevRel','simFail','omegaEAmp','powAmp', ...
%        'powTs','omegaETs','pScavAmp','pScavTs','uGovAmp','uGovTs', ...
%        'omegaTAmp','omegaTTs','FCylMax');
end;
%}
%{a
addpath('C:\Users\yum\Dropbox\Propeller engine dynamics\Kevin\8RTFLEX65D\result\FreqRespResult');

SFOCDevMax = zeros(noExp,1);
TsAtSFOCDevMax = zeros(noExp,1);
AmpAtSFOCDevMax = zeros(noExp,1);
omegaEAmpMax = zeros(noExp,1);
TsAtomegaEAmpMax = zeros(noExp,1);
AmpAtomegaEAmpMax = zeros(noExp,1);
powAmpMax = zeros(noExp,1);
TsAtpowAmpMax = zeros(noExp,1);
AmpAtpowAmpMax = zeros(noExp,1);
pScavAmpMax = zeros(noExp,1);
TsAtpScavAmpMax = zeros(noExp,1);
AmpAtpScavAmpMax = zeros(noExp,1);
uGovAmpMax = zeros(noExp,1);
TsAtuGovAmpMax = zeros(noExp,1);
AmpAtuGovAmpMax = zeros(noExp,1);
omegaTAmpMax = zeros(noExp,1);
TsAtomegaTAmpMax = zeros(noExp,1);
AmpAtomegaTAmpMax = zeros(noExp,1);
noSimFail = zeros(noExp,1);
FCylMaxMax = zeros(noExp,1);
R0 = zeros(7,7,noExp);

for i = 1:noExp
    fileName = strcat('result',num2str(i),'.mat');
    load(fileName);
    simFail = (simFail == 1);
    SFOCDevRel(2:end,2:end) = SFOCDevRel(2:end,2:end).*simFail;
    omegaEAmp = omegaEAmp.*simFail;
    powAmp = powAmp.*simFail;
    pScavAmp = pScavAmp.*simFail;
    uGovAmp = uGovAmp.*simFail;
    omegaTAmp = omegaTAmp.*simFail;
    noSimFail(i) = 30-sum(sum(simFail));
    
    %SFOCDev
    [temp tempIdx1] = max(SFOCDevRel);
    [SFOCDevMax(i) tempIdx2] = max(temp);
    TsAtSFOCDevMax(i) = period(tempIdx2-1);
    AmpAtSFOCDevMax(i) = amplitude(tempIdx1(tempIdx2)-1);
    %omegaEAmp
    [temp, tempIdx1] = max(omegaEAmp);
    [omegaEAmpMax(i), tempIdx2] = max(temp);
    TsAtomegaEAmpMax(i) = period(tempIdx2);
    AmpAtomegaEAmpMax(i) = amplitude(tempIdx1(tempIdx2));
    %powAmp
    [temp, tempIdx1] = max(powAmp);
    [powAmpMax(i), tempIdx2] = max(temp);
    TsAtpowAmpMax(i) = period(tempIdx2);
    AmpAtpowAmpMax(i) = amplitude(tempIdx1(tempIdx2));
    %pScavAmp
    [temp, tempIdx1] = max(pScavAmp);
    [pScavAmpMax(i), tempIdx2] = max(temp);
    TsAtpScavAmpMax(i) = period(tempIdx2);
    AmpAtpScavAmpMaxv = amplitude(tempIdx1(tempIdx2));
    %uGovAmp
    [temp, tempIdx1] = max(uGovAmp);
    [uGovAmpMax(i), tempIdx2] = max(temp);
    TsAtuGovAmpMax(i) = period(tempIdx2);
    AmpAtuGovAmpMax(i) = amplitude(tempIdx1(tempIdx2));
    %omegaTAmp
    [temp, tempIdx1] = max(omegaTAmp);
    [omegaTAmpMax(i), tempIdx2] = max(temp);
    TsAtomegaTAmpMax(i) = period(tempIdx2);
    AmpAtomegaTAmpMax(i) = amplitude(tempIdx1(tempIdx2));
    %FCylMax
    [temp, tempIdx1] = max(FCylMax);
    [FCylMaxMax(i), tempIdx2] = max(temp);

    %[
    
    
    SFOCDev = SFOCDevRel(2:end,2:end);
    SFOCDev = reshape(SFOCDev(simFail),[],1);
    omegaEAmp = reshape(omegaEAmp(simFail),[],1);
    powAmp = reshape(powAmp(simFail),[],1);
    pScavAmp = reshape(pScavAmp(simFail),[],1);
    uGovAmp = reshape(uGovAmp(simFail),[],1);
    omegaTAmp = reshape(omegaTAmp(simFail),[],1);
    FCylMax = reshape(FCylMax(simFail),[],1);
    
    R0(:,:,i) = corr([SFOCDev omegaEAmp powAmp pScavAmp uGovAmp omegaTAmp FCylMax]);
end;
idx = noSimFail <= 20;
R01 = R0(:,:,idx);

temp = mean(R01,3);
tempStd = std(R01,0,3);
[m] = size(temp);
for i = 1:m
    temp(i+1:end,i) = tempStd(i+1:end,i);
end;
R1 = temp;
clear temp tempStd

KpX = eng.control.gov.Kp*KpMultiplier(dFF(:,1))';
BWX = eng.control.gov.LPBW*BWMultiplier(dFF(:,2))';
FMaxX = eng.control.smokeLim.FMax*FMaxMultiplier(dFF(:,3))';

inputVar = [KpX(idx) BWX(idx) FMaxX(idx)];
outputVar = [SFOCDevMax(idx) omegaEAmpMax(idx) powAmpMax(idx) pScavAmpMax(idx) uGovAmpMax(idx) omegaTAmpMax(idx) noSimFail(idx) FCylMaxMax(idx)];

R2 = corr([inputVar outputVar]);
[~,m] = size(inputVar);
R2 = R2(1:m,m+1:end);

outputVar = [reshape(R01(1,2,:),[],1) reshape(R01(1,3,:),[],1) ...
            reshape(R01(1,4,:),[],1) reshape(R01(1,5,:),[],1) ...
            reshape(R01(1,6,:),[],1) reshape(R01(1,7,:),[],1)];
R3 = corr([inputVar outputVar]);
[~,m] = size(inputVar);
R3 = R3(1:m,m+1:end);


    


%}