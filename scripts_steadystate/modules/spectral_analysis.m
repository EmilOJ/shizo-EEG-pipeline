function [freq] = spectral_analysis(pars, data)
    cfg = [];
    cfg.conditions = {
        'eyes_closed'
        'eyes_open'
    };

    cfg = merge_pars_with_cfg(pars, cfg, 'spectral_analysis');
    
    %% Epoch
    cfg_1 = [];
    cfg_1.length = 2;
    cfg_1.overlap = 0.5;
    
    data = ft_redefinetrial(cfg_1, data);
    trial_real_length = data.fsample * (cfg_1.length - cfg_1.overlap);
    
    proc_data = read_proc_notes(pars);
    
    for icondition = 1:length(cfg.conditions)
        condition = cfg.conditions{icondition};
        experiment_ranges = floor([proc_data.(pars.participant).([condition '_start']); proc_data.(pars.participant).([condition '_stop'])] / trial_real_length);

        trials = [];
        for i = 1:size(experiment_ranges, 2)
            trials = [trials experiment_ranges(1, i) : experiment_ranges(2, i)];
        end


        cfg_2= [];
        cfg_2.trials = trials;
        data_cropped = ft_selectdata(cfg_2, data);

        %% Spectral decomposition
        cfg_spectral              = [];
        cfg_spectral.method       = 'mtmfft';
        cfg_spectral.taper        = 'hanning';
        cfg_spectral.foi          = 1:0.1:100;                         

        freq.(condition) = ft_freqanalysis(cfg_spectral, data_cropped);
    end
end