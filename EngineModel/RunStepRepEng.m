addpath('model');
path = 'C:\Users\yum\Dropbox\Propeller engine dynamics\Kevin\8RTFLEX65D';
cd(path);
load('8RT-FLEX68-D.mat');

%% Vessel information
vSDes = 10;
vS0 = 0;
%% Controller mode
vSCont = 0;
engSCont = 1;

%% Engine Parameters 
CompleteAll = 0;
initRPM = [70.0;84.4];
finalRPM = [95.0;95.0];
mdl = 'EngSimulation8RTFLEX68D_Transient_StepResp';
while CompleteAll == 0
    cd(path);
    open_system(mdl);
    try 
        for iii = 1:1
            pathName = strcat('c:\temp\StepRespResult8RTFLEX68D_ScavNew',num2str(iii))
            initOmegaE0 = initRPM(iii)/30*pi;
            stepRPMCase = finalRPM(iii) - initRPM(iii);
            runT = 300;
% 
            %% DOE of parameters
            
            KpMultiplier = 1;
            BWMultiplier = 1;
            jShaftMultiplier = 1;
            jTCMultiplier = 1;
            
            dFF = fullfact([3 3 3 3]);
            
            noExp = length(dFF);
            
            %% Run Step Response Analysis
            caseInit = 9;
            eng.engLoad0 = eng_data.perf.Pe(caseInit)/eng_data.perf.Pe(2);
            EngineSystemParameters8RTFLEX68D;
            stepRPM = stepRPMCase;
            initStepRPM = initRPM(iii) - eng.omegaE0*30/pi;
            stepTime = 150;
            initStepTime = 10;
            for ii = 1:1
                EngineSystemParameters8RTFLEX68D;
                eng.control.gov.Kp = eng.control.gov.Kp*KpMultiplier(dFF(ii,1));
                eng.control.gov.LPBW = eng.control.gov.LPBW*BWMultiplier(dFF(ii,2));
                eng.jShaft = eng.jShaft*jShaftMultiplier(dFF(ii,3));
                eng.turbo.jTC = eng.turbo.jTC*jTCMultiplier(dFF(ii,4));
                path = pwd;
                cd(pathName);
                fileName = strcat('s',num2str(ii),'.mat');
                if exist(fileName)== 2
                    cd(path);
                else
                    cd(path);
                    fprintf('Running case %d out of %d\n',ii, noExp);        
                    fprintf('Kp LPBW jShaft jTC: %2.1f \t %2.1f \t %2.1f \t %2.1f\n',eng.control.gov.Kp,eng.control.gov.LPBW,eng.jShaft,eng.turbo.jTC);
                    q = 0;
                    complete = 0;
                    while (complete == 0);
                        q = q + 1;
                        if q > 10
                            break;
                        end;
                        try
                            tic;
                                set_param(mdl, 'LoadInitialState', 'off'); %, 'InitialState','initState');
                                simOut = sim(mdl,'StopTime', num2str(runT));
                            toc;
                        catch err
                            fprintf([err.identifier '\n']);
                        continue
                        end;
                        complete = 1;
                    end;
                    path = pwd;
                    cd(pathName);
                    save(fileName,'simOut','eng'); 
                    cd(path);
                    clear simOut
                end;
            end;
        end;
        CompleteAll = 1;
    catch err 
        CompleteAll = 0;
        fprintf([err.identifier '\n']);
        close_system(mdl,0);
        continue
    end;
end;