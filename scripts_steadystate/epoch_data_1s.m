function [] = epoch_data_1s(experiment, participant, ICA)
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    cfg.inputfile = cfg.files.raw_filtered;
    cfg.outputfile = [cfg.files.raw_filtered_artifacts_rejected_ condition{1} '.mat'];
    
    
    
    cfg.trialfun             = 'ft_trialfun_general'; 
    cfg.trialdef.triallength = 1; % in seconds
    cfg.trialdef.ntrials     = inf;  

    cfg.dataset = cfg.files.raw;
    hdr = ft_read_header(cfg.dataset); 

    
end