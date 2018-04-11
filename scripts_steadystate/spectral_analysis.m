function [] = spectral_analysis(experiment, participant, ICA)
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    cfg.inputfile = cfg.files.raw_filtered_epoched;
    cfg.outputfile = cfg.files.raw_filtered_epoched_spectral;
    
%     cfg.method       = 'mtmconvol';
    cfg.method       = 'mtmfft';
    cfg.taper        = 'hanning';
    cfg.foi          = 1:0.1:60;                         % analysis 2 to 30 Hz in steps of 2 Hz 
%     cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;   % length of time window = 0.5 sec
% %     cfg.toi          = -0.5:0.05:1.5;                  % time window "slides" from -0.5 to 1.5 sec in steps of 0.05 sec (50 ms)
%     cfg.toi = 'all';
%     cfg.pad = 'nextpow2';
    ft_freqanalysis(cfg);
    
end