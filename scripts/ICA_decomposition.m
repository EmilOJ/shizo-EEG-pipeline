function [ICA_components] = ICA_decomposition(pars, data)
    % Performs ICA decomposition. Outputs the ICA components for inspection   
    
    disp('*** Performing ICA decomposition ***');
    
    if ~isfield(pars,'experiment')
        error('Missing parameter experiment')
    end
    if ~isfield(pars,'participant')
        error('Missing parameter participant')
    end
    if ~isfield(pars,'my_data_folder')
        error('Missing parameter participant')
    end

    %% Config
    cfg = [];
    
    % 2. Filter config
    cfg.hpfilter                = 'yes';
    cfg.hpfreq                  = 1; %Hz
    cfg.lpfilter                = 'yes';
    cfg.lpfreq                  = 40; %Hz
    cfg.hpfilttype              = 'fir';
    
    % 3. Seperate into 1 second epochs config
    cfg.trialfun                = 'ft_trialfun_general';
    cfg.trialdef.triallength    = 1; % duration in seconds
    cfg.trialdef.ntrials        = inf;
    
    % ICA config
    cfg.method                  = 'runica';
    
    % Select channels
    cfg.channel = get_channellist(pars.experiment, pars.participant);
    
    % Apply custom parameters
    cfg                         = merge_pars_with_cfg(pars, cfg, 'ICA_decomposition');
    
    %% Processing
    % Epoch
    cfg                         = ft_definetrial(cfg);
    
    % Preprocess (with above configs)
    data_epoch_1s               = ft_preprocessing(cfg, data);
    
    try
        % Record elapsed time
        tic;
        
        % ICA decomposition
        ICA_components = ft_componentanalysis(cfg, data_epoch_1s);
        
        % Show elapsed time
        ICA_elapsed_time = toc;
        disp(['Preprocessing time: '  num2str(ICA_elapsed_time) ' seconds']);
        
        save([pars.my_data_folder, filesep, pars.participant, filesep, 'data_out_module_', 'ICA_decomposition','.mat'], 'ICA_components');
    catch
        disp('Could not run ICA');
    end
end







