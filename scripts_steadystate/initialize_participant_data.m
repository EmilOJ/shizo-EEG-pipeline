function [] = initialize_participant_data(experiment, participant, ICA) 
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    
    cfg.dataset = cfg.files.raw;
    cfg.continuous = 'yes';
    data = ft_preprocessing(cfg);
    
    selectchannels = ft_channelselection({'all', '-25', '-EKG', '-Body Pos', '-CPAP', '-Pulse', '-Photic', '-Rate', '-IBI', '-Bursts', '-Suppr'}, data.label);
    data = ft_selectdata(data, 'channel', selectchannels);
    
    save(cfg.files.raw_mat, 'data');
end