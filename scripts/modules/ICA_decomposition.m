function [ICA_components] = ICA_decomposition(pars, data)
    % Performs ICA decomposition. Outputs the ICA components for inspection   
    % 1. read the data
    % 2. hp filter (1 Hz) & maybe lp filter (aprpox. 40 Hz)
    % 3. epoch into dummy consecutive epochs (length approx. 1sec)
    % 4. Remove bad channels from visual inspection
    % (4. get rid of non-stereotypical artifacts (use probability and
    % kurtosis functions in eeglab, start with SD=3, for noisy data go down to 2, for good data go up to 4))
    % 5. train extended infomax ica (no dimensionality reduction)
    % 6. save the unmixing weights (EEG.icaweights & EEG.icasphere), discard the rest
    % 7. read in the raw data again
    % 8. apply the ica weights to the unprocessed raw data
    % 9. filter and re-reference the raw data, tailored towards the features of interest
    % 10. get rid of artifacts by back-projection of all but the artifact ICs (I suggest using CORRMAP for the classification process, it is near objective and very robust, we get plenty positive feedback from other labs)
    % 11. extract events      
    %% Config
    cfg = [];
    
    cfg.channel = get_channellist(pars);
    
    % Raw data for defining trials
    cfg.dataset = [pars.subject_data_dir, filesep , pars.participant, '.e'];
    
    % Filter config
    cfg.hpfilter                = 'yes';
    cfg.hpfreq                  = 1; %Hz
    cfg.hpfilttype              = 'fir';
    
    % Seperate into 1 second epochs config
    cfg.trialfun                = 'ft_trialfun_general';
    cfg.trialdef.triallength    = 2; % duration in seconds
    cfg.trialdef.ntrials        = inf;
%     cfg.reref                   = 'yes';
%     cfg.refmethod               = 'avg'; 
%     cfg.refchannel              = get_channellist(pars);
%     
    % ICA config
    cfg.method                  = 'runica';
    
    % Select channels
    cfg.channel = get_channellist(pars);
    
    % Apply custom parameters
    cfg                         = merge_pars_with_cfg(pars, cfg, 'ICA_decomposition');
    
    %% Processing
    
    % Preprocess (with above configs)
    data                        = ft_preprocessing(cfg, data);
    
    % Epoch
    cfg                         = ft_definetrial(cfg);
    data_epoch_1s               = ft_redefinetrial(cfg, data);
    clear data;
    
    % SQUID jump artifact rejection
    % channel selection, cutoff and padding
    cfg.artfctdef.zvalue.channel    = get_channellist(pars);
    cfg.artfctdef.zvalue.cutoff     = 20;
    cfg.artfctdef.zvalue.trlpadding = 0;
    cfg.artfctdef.zvalue.artpadding = 0;
    cfg.artfctdef.zvalue.fltpadding = 0;

    % algorithmic parameters
    cfg.artfctdef.zvalue.cumulative    = 'yes';
    cfg.artfctdef.zvalue.medianfilter  = 'yes';
    cfg.artfctdef.zvalue.medianfiltord = 9;
    cfg.artfctdef.zvalue.absdiff       = 'yes';

    % make the process interactive
    cfg.artfctdef.zvalue.interactive = 'no';
    
    cfg.continuous  = 'no';

    cfg = rmfield(cfg, 'dataset');
    cfg = ft_artifact_zvalue(cfg, data_epoch_1s);
    data_epoch_1s = ft_rejectartifact(cfg, data_epoch_1s);
    
    try
        % Record elapsed time
        tic;
        disp('*** Performing ICA decomposition ***');
        
        % ICA decomposition
        ICA_components = ft_componentanalysis(cfg, data_epoch_1s);
        
        save([pars.subject_data_dir, filesep, 'data_out_module_', 'ICA_decomposition','.mat'], 'ICA_components');
    catch
        disp('Could not run ICA');
    end
end







