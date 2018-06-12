clc; close all; clear all;
tic;
pars = struct;



parfor participant = 1:22%length(participants)
    
    participants = {
        's1001'
        's1003'
        's1004'
        's1005'
        's1006'
        's1007'
        's1008'
        's1009'
        's1010'
        's1011'
        's1012'
        's1013'
        's1014'
        's1015'
        's1016'
        's1017'
        's1018'
        's1019'
        's1020'
%         's1021'
        's1022'
        's1023'
        's1024'
    };
    
    disp(['*********** Processing participant: ' participants{participant} ' ***********']);
    pars.participant = participants{participant};
    
    %% Custom settings
    pars.data_type = 'continuous'; % or ERP
    
    pars.ke_filter.lpfreq = 105;
    pars.ke_filter.lpfiltdf  = 2;
    
    pars.spectral_analysis.rerun = 'yes';
%     pars.spectral_analysis.conditions = {
%         'eyes_closed'
%         'eyes_open'
%     };

    % Steady-state
    pars.module_order= {
        'ICA_reconstruction'
        'ke_filter'
        'spectral_analysis'
    };


    %% Initialization
    [pars, data] = init_pipeline(pars);

    %% Pipeline
    for i_module = 1:length(pars.module_order) %iterate through all modules
       if i_module == length(pars.module_order)
           is_last_module = true;
       else
           is_last_module = false;
       end
       
       data = run_module(pars, data, i_module, is_last_module);
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

function [data] = run_module(pars, data, module, is_last_module)
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
      
      disp('**** Saving processing step to disk... ***');
      %saving both data and pars used for the data
      if is_last_module
          disp('**** Saving processing step to disk... ***');
          save([pars.subject_data_dir, filesep, 'data_out_module_',num2str(module),'_final.mat'],'data')
          save([pars.subject_data_dir, filesep, 'pars_used_for_module_',num2str(module),'_final.mat'],'pars')
      else
          disp('**** Saving processing step to disk... ***');
          save([pars.subject_data_dir, filesep, 'data_out_module_',num2str(module),'.mat'],'data')
          save([pars.subject_data_dir, filesep, 'pars_used_for_module_',num2str(module),'.mat'],'pars')
      end
   end
end


