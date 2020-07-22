%% Tutorial: Performing Sobol GSA on Ishigami function
% By Resul Al @DTU

% Model: Ishigami function [https://www.sfu.ca/~ssurjano/ishigami.html]
f = @(x) sin(x(:,1)) + 7.*sin(x(:,2)).^2 + 0.1.*x(:,3).^4.*sin(x(:,1));  
N = 1e4; % Number of MC samples. Minimum recommended: 1e3

% Uniform Input Space
pars = {'x1','x2','x3'}; % input parameter names
lbs  = -pi.*ones(1,3);   % lower bounds of input parameters
ubs  =  pi.*ones(1,3);   % upper bounds of input parameters
InputSpace = {'ParNames',pars,'LowerBounds',lbs,'UpperBounds',ubs};

% call easyGSA tool to perform Sobol sensitivity analysis with MC approach
[Si,STi] = easyGSA(f,N,InputSpace{:},'UseParallel',true)

% Suppress command line messages
[Si,STi] = easyGSA(f,N,InputSpace{:},'UseParallel',true,'Verbose',false)

% Change sampling method and MC estimator
[mcSi,mcSTi] = easyGSA(f,N,InputSpace{:}, ...
                    'SamplingMethod','LHS',... % default: 'Sobol'
                    'Estimator','Saltelli')    % default: 'Jansen'

% use a GPR model instead
[gprSi, gprSTi] = easyGSA(f,N,InputSpace{:},'UseSurrogate','GPR')
 
% use an ANN model instead
[annSi, annSTi] = easyGSA(f,N,InputSpace{:},'UseSurrogate','ANN')
                
                
% Analytical first order indices from doi:10.1016/j.ress.2008.07.008
Si_analytical = [0.3139 0.4424 0]';

% Plot comparative results
T = table(Si_analytical,mcSi,gprSi,annSi,...
    'VariableNames', {'Analytical','MonteCarlo','GPR','ANN'}, ...
    'RowNames', pars);
fprintf("\n\nFirst Order Sensitivity Indices of Ishigami function\n\n")
disp(T)

H = [Si_analytical,mcSi,gprSi,annSi]; c = categorical(pars);
bar(c,H); legend({'Analytical','MonteCarlo','GPR','ANN'});
ylabel('First Order Sobol indices'); xlabel('Input Parameters');
print('Si_ishigami','-dpng','-r1200')

H = [mcSTi,gprSTi,annSTi]; c = categorical(pars);
bar(c,H); legend({'MonteCarlo','GPR','ANN'});
ylabel('Total Order Sobol indices'); xlabel('Input Parameters');
print('STi_ishigami','-dpng','-r1200')