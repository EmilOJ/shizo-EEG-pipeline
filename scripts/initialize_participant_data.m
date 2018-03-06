function [] = initialize_participant_data(experiment, participant, ICA) 
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    
    cfg.dataset = cfg.files.raw;
    cfg.outputfile = cfg.files.raw_mat;
    
    ft_preprocessing(cfg);
end