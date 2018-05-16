function [] = ICA_decomposition()
    tic; % Record elapsed time
    
    disp('*** Performing ICA decomposition ***');
    
    
    cfg_epoch_1s = initialize_participant_cfg(experiment, participant);
    cfg_epoch_1s.dataset                 = cfg_epoch_1s.files.raw;

    % 2. Filter config
    cfg_epoch_1s.hpfilter                = 'yes';
    cfg_epoch_1s.hpfreq                  = 1; %Hz
    cfg_epoch_1s.lpfilter                = 'yes';
    cfg_epoch_1s.lpfreq                  = 40; %Hz
    cfg_epoch_1s.hpfilttype              = 'fir';
    
    % 3. Seperate into 1 second epochs config
    cfg_epoch_1s.trialfun                = 'ft_trialfun_general';
    cfg_epoch_1s.trialdef.triallength    = 1; % duration in seconds
    cfg_epoch_1s.trialdef.ntrials        = inf; 
    cfg_epoch_1s                         = ft_definetrial(cfg_epoch_1s);

    % TODO: 4. Remove bad channels
    

    % Preprocess (with above configs)
    data_epoch_1s                        = ft_preprocessing(cfg_epoch_1s);
    
    % Show elapsed time
    preproc_time = toc;
    disp(['Preprocessing time: '  num2str(preproc_time) ' seconds']);

    % 5. ICA
    cfg_epoch_1s.method                  = 'runica';
    try
        % ICA decomposition
         comp = ft_componentanalysis(cfg_epoch_1s, data_epoch_1s);
    catch
        disp('Could not run ICA');
    end

    % TODO: Save decomposition
    

   clear all;
end







