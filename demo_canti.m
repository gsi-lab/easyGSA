% Tutorial: Perform GSA on Cantilever Beam functions (multiple outputs).

Model = @cantibeam; % handle to the cantibeam.m file
N = 2e3; % Number of MC samples

% Normal Input Space definiton
pars   = {'R','E','X','Y'};     % input parameter names
means  = [4e4 2.9e7 5e2 1e3];   % mean values of input parameters
stds   = [2e3 1.45e6 1e2 1e2];  % std deviations of input parameters
InputSpace = {'ParNames',pars,'Means',means,'Sigmas',stds};

% call easyGSA tool to perform Sobol sensitivity analysis with MC approach
[mcSi,mcSTi,results] = easyGSA(Model,N,InputSpace{:},'UseParallel',true)
                       

% visualize input sampling matrices                     
figure; [~,ax]=plotmatrix(results.A); np=numel(pars);
for i=1:np  
    ylabel(ax(i,1),pars(i));  
    xlabel(ax(np,i),pars(i));
end
print('canti_sampling','-dpng','-r1200')


% Find Sobol indices using a GPR model instead of the original model
[gprSi,gprSTi,results] = easyGSA(Model,N,InputSpace{:},...
                            'UseParallel',true,...
                            'UseSurrogate','GPR')
                        
                        
% Find Sobol indices using an ANN model instead of the original model
[annSi,annSTi,results] = easyGSA(Model,N,InputSpace{:},...
                            'UseParallel',true,...
                            'UseSurrogate','ANN')                        
                        
% Plot comparative results
n_outs = size(results.yA,2);
for o=1:n_outs
    H = [mcSi(:,o),gprSi(:,o),annSi(:,o)]; c = categorical(pars);
    bar(c,H); legend({'MonteCarlo','GPR','ANN'},'Location', 'Best');
    ylabel('First Order Sobol indices'); xlabel('Input Parameters');
    print(['Si_canti','_',num2str(o)],'-dpng','-r1200')

    H = [mcSTi(:,o),gprSTi(:,o),annSTi(:,o)]; c = categorical(pars);
    bar(c,H); legend({'MonteCarlo','GPR','ANN'},'Location', 'Best');
    ylabel('Total Order Sobol indices'); xlabel('Input Parameters');
    print(['STi_canti','_',num2str(o)],'-dpng','-r1200')
end