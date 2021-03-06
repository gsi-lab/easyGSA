%% Example: Standardized regression coefficients using easyGSA
% By Resul Al @DTU

% Load a built-in dataset for the analysis
[X,Y] = chemical_dataset; 
Data.X = X'; % rows are observations.
Data.Y = Y'; % columns are outputs.

% call the easyGSA tool with the following arguments.
[SRCs,results] = easyGSA('UserData',Data,...
                         'Method','SRC')

% Visualize the SRCs in a barplot
H = [SRCs]; c = categorical(strseq('x',1:8));
bar(c,H); 
ylabel('Standardized regression coefficients'); xlabel('Input Parameters');
print('ChemData-SRC','-dpng','-r600');