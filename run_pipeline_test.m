clc; close all; clear all;
pars = struct;

%% Custom settings
pars.participant = 's1001';
pars.experiment = 'steady_state';

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
function [] = init_data(pars)
    if exist([pars.my_data_folder,filesep,pars.participant,filesep,'data_init.mat']) == 0
       disp(['*** data_init.mat does not exist in ',pars.my_data_folder,filesep,pars.participant ' ***']);
       disp('Creating it now...');
       initialize_participant_data(pars.participant);
    end
end

function [pars, data] = init_pipeline(pars)
    % Parameters
    pars = initialize_pars(pars);

    % Data
    init_data(pars);
    data = importdata([pars.my_data_folder,filesep,pars.participant,filesep,'data_init.mat']);
end

function [data] = run_module(pars, data, module)
   data_exists = check_for_old_data(pars, module);
   if data_exists
       data = importdata([pars.my_data_folder,filesep,pars.participant,filesep,'data_out_module_',num2str(module),'.mat']);
       disp('*** Found previous run of this module with same parameters. Continuing... ***');
   else
       %running the function for the current module
      data = eval([pars.module_order{module},'(pars,data);']);
      %saving both data and pars used for the data
      save([pars.my_data_folder,filesep,pars.participant,filesep,'data_out_module_',num2str(module),'.mat'],'data')
      save([pars.my_data_folder,filesep,pars.participant,filesep,'pars_used_for_module_',num2str(module),'.mat'],'pars')
   end
end

