% Tutorial: Perform GSA on g-function of Sobol

f = @(x) gSobol(x);
N = 1e6; % Number of MC samples

pars = strseq('x',1:5); % input parameter names
lbs  = zeros(1,5);      % lower bounds of input parameters
ubs  = ones(1,5);       % upper bounds of input parameters
InputSpace = {'ParNames',pars,'LowerBounds',lbs,'UpperBounds',ubs};

% Monte Carlo indices from the original model
[mcSi,mcSTi] = easyGSA(f,N,InputSpace{:});

% GPR indices
[gprSi, gprSTi] = easyGSA(f,N,InputSpace{:},'UseSurrogate','GPR')
 
% ANN indices
[annSi, annSTi] = easyGSA(f,N,InputSpace{:},'UseSurrogate','ANN')             
                
% Analytical first order indices from doi:10.1016/j.ress.2008.07.008
Si_analytical = [0.48 0.21 0.12 0.08 0.05]'; 

T = table(Si_analytical,mcSi,gprSi,annSi,...
    'VariableNames', {'Analytical','MonteCarlo','GPR','ANN'}, ...
    'RowNames', strseq('S',1:5));
fprintf("\n\nFirst Order Sensitivity Indices of Sobol' g-function\n\n")
disp(T)


% put all indices in a bar plot
H = [Si_analytical,mcSi,gprSi,annSi]; c = categorical(strseq('x',1:5));
bar(c,H); legend({'Analytical','MonteCarlo','GPR','ANN'});
ylabel('First Order Sobol indices'); xlabel('Input Parameters');
print('gSobol','-dpng','-r1200')
