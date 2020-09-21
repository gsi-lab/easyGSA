% Inputting your own dataset to perform GPR and ANN-based GSA
% By Resul Al @DTU

% Step 1: Load your own data, eg. simulation results, etc.
[X,Y]=chemical_dataset; X=X'; Y=Y'; % a standard MATLAB dataset

% Step 2: Put your data into a struct. Only X and Y fields are expected.
Data.X = X; % inputs
Data.Y = Y; % outputs

% Step 3: pass your data into easyGSA
[Si,STi,results] = easyGSA('UserData',Data) % uses GPR models by default.

% Step 4: Fit ANN models and perform a Sobol GSA
[Si,STi,results] = easyGSA('UserData',Data,...
                           'UseSurrogate','ANN')

% Step 5: Change size of sampling matrices, N, used for Sobol analysis
[Si,STi,results] = easyGSA('UserData',Data,...
                           'UseSurrogate','ANN','N',1e4)
                       
                       
% Step 5: Change size of sampling matrices used for Sobol analysis
[Si,STi,results] = easyGSA('UserData',Data,...
                           'UseSurrogate','ANN',...
                           'N',4e4,'SamplingMethod','LHS')
                       
                       
% Change the input space to normal.
InputSpace={'Means',mean(Data.X),'Sigmas',std(Data.X)};
[Si,STi,results] = easyGSA('UserData',Data,...
                           'UseSurrogate','ANN',...
                           InputSpace{:})