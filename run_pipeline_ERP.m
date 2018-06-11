clc; close all; clear all;
tic;
pars = struct;

participants = {
    's1001'
%     's1003'
%     's1004'
%     's1005'
%     's1006'
%     's1007'
%     's1008'
%     's1009'
%     's1010'
%     's1011'
%     's1012'
%     's1013'
%     's1014'
%     's1015'
%     's1016'
%     's1017'
%     's1018'
%     's1019'
%     's1020'
%     's1021'
%     's1022'
%     's1023'
%     's1024'
};

for participant = 1:length(participants)
    disp(['*********** Processing participant: ' participants{participant} ' ***********']);
    pars.participant = participants{participant};
    
    %% Custom settings
    % One of two:
    % pars.data_type = 'continuous';
    pars.data_type = 'epoch';
    
    pars.epoch.latency = 0.2; %seconds

%     Names of the modules in the order they should be run.
    pars.module_order= {
        % Before Epoch
        'ICA_reconstruction'
        'visual_inspect_data'
        'ke_filter'
        'ke_rereference'
        'epoch'
        
        % After Epoch
        'epochs_reject_artifacts_auto'
    };
% 
%      pars.module_order= {
%         % Before Epoch
%         'ICA_decomposition'
%     };

    %% Initialization
    [pars, data] = init_pipeline(pars);

    %% Pipeline
    for i_module = 1:length(pars.module_order) %iterate through all modules
       data = run_module(pars, data, i_module);
    end
end

disp(['**** Pipeline finished running in ', num2str(toc), ' seconds ****']);

%% Helper functions
function [pars, data] = init_pipeline(pars)
    disp('**** Initializaing pipeline... ****');
    % Parameters
    pars = initialize_pars(pars);

    % Data
    init_data(pars);

    disp('**** Loading data... ****');
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
   disp(['**** Running module: ', pars.module_order{module}, ' ****']);
   data_exists = check_for_old_data(pars, module);
   if data_exists
       data = importdata([pars.subject_data_dir, filesep, 'data_out_module_', num2str(module), '.mat']);
       disp('*** Found previous run of this module with same parameters. Continuing... ***');
   else
      if contains(pars.module_order{module}, 'epochs')
          conditions = fields(data);
          for icondition = 1:length(conditions)
              condition = conditions{icondition};
              disp(['*** On condition: ' condition]);
              data.(condition) = eval([pars.module_order{module},'(pars,data.(condition));']);
          end
              
      else
           %running the function for the current module
          data = eval([pars.module_order{module},'(pars,data);']);
      end
      
      %saving both data and pars used for the data
          disp('**** Saving processing step to disk... ***');
          save([pars.subject_data_dir, filesep, 'data_out_module_',num2str(module),'.mat'],'data')
          save([pars.subject_data_dir, filesep, 'pars_used_for_module_',num2str(module),'.mat'],'pars')
   end
end


