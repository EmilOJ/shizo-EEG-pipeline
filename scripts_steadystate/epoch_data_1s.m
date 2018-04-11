function [] = epoch_data_1s(experiment, participant, ICA)
    cfg_1 = initialize_participant_cfg(experiment, participant, ICA);
    
    cfg_1.inputfile = cfg_1.files.raw_filtered;
    data_org = ft_preprocessing(cfg_1);
    
    cfg_2 = [];
    cfg_2.length = 2;
    cfg_2.overlap = 0.5;
    
    data = ft_redefinetrial(cfg_2, data_org);
    trial_real_length = data.fsample * (cfg_2.length - cfg_2.overlap);
    
    proc_data = cfg_1.proc_data.(cfg_1.subjectstr);
    experiment_ranges = floor([proc_data.([experiment '_start']); proc_data.([experiment '_stop'])] / trial_real_length);
    
    trials = [];
    for i = 1:size(experiment_ranges, 2)
        trials = [trials experiment_ranges(1, i) : experiment_ranges(2, i)];
    end
    
    
    cfg = [];
    cfg.trials = trials;
    data = ft_selectdata(cfg, data);
    save(cfg_1.files.raw_filtered_epoched, 'data');
end