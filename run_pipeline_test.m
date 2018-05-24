clc; close all; clear all;
pars = struct;

%% Custom settings
pars.participant = 's1003';
% pars.data_type = 'continuous';
pars.data_type = 'epoch';

% Names of the modules in the order they should be run.
pars.module_order= {
    'rereference'
};

%% Initialization
[pars, data] = init_pipeline(pars);

%% Pipeline
for i_module = 1:length(pars.module_order) %iterate through all modules
   data = run_module(pars, data, i_module);
end


%% Helper functions
function [pars, data] = init_pipeline(pars)
    disp('*** Initializaing pipeline... ***');
    % Parameters
    pars = initialize_pars(pars);

    % Data
    init_data(pars);
    
    disp('*** Loading data... ***');
    data = importdata([pars.subject_data_dir,filesep,'data_init.mat']);
end

function [] = init_data(pars)
    if exist([pars.subject_data_dir ,filesep,'data_init.mat']) == 0
       disp(['*** data_init.mat does not exist in ',pars.subject_data_dir ' ***']);
       disp('*** Creating it now... ***');
       initialize_participant_data(pars.participant);
    end
end

function [data] = run_module(pars, data, module)
   disp(['*** Running module: ', pars.module_order{module}, ' ***']);
   data_exists = check_for_old_data(pars, module);
   if data_exists
       data = importdata([pars.subject_data_dir, filesep, 'data_out_module_', num2str(module), '.mat']);
       disp('*** Found previous run of this module with same parameters. Continuing... ***');
   else
       %running the function for the current module
      data = eval([pars.module_order{module},'(pars,data);']);
      %saving both data and pars used for the data
      save([pars.subject_data_dir, filesep, 'data_out_module_',num2str(module),'.mat'],'data')
      save([pars.subject_data_dir, filesep, 'pars_used_for_module_',num2str(module),'.mat'],'pars')
   end
end

