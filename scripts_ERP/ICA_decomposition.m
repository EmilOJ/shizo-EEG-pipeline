function [ICA_components] = ICA_decomposition(pars, data)
    % Performs ICA decomposition. Outputs the ICA components for inspection   
    disp('*** Performing ICA decomposition ***');
    
    
    cfg = initialize_participant_cfg(experiment, participant);

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
    cfg                         = ft_definetrial(cfg);

    % Remove bad channels
    cfg.channel = get_channellist();
    
    % Preprocess (with above configs)
    data_epoch_1s                        = ft_preprocessing(cfg, data);
    
    % 5. ICA
    cfg.method                  = 'runica';
    try
        % Record elapsed time
        tic;
        
        % ICA decomposition
        ICA_components = ft_componentanalysis(cfg, data_epoch_1s);
        
        % Show elapsed time
        ICA_elapsed_time = toc;
        disp(['Preprocessing time: '  num2str(ICA_elapsed_time) ' seconds']);
    catch
        disp('Could not run ICA');
    end
end







