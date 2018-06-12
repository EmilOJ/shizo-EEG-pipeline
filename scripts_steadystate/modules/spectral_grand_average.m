function [] = spectral_grand_average(pars)
    cfg.conditions = {
        'eyes_closed'
        'eyes_open'
    };

    for icondition = 1:length(cfg.conditions)
        condition = cfg.conditions{icondition};
        for i = 1:length(pars.participants)
           participant = pars.participants{i};
           data = get_latest_data(pars, participant);
           freq{i} = data.(condition);
        end
        
        freq_GA = ft_freqgrandaverage(cfg, freq{:});
        
        disp('*** Saving result to disk ***');
        save([pars.my_data_folder filesep 'GA_' condition '.mat'], 'freq_GA');
    end
end

