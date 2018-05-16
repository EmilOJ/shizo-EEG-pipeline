function [] = my_filter(experiment, participant, ICA, only_demean)    
    ;
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    if ICA
        cfg.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat']; 
        cfg.outputfile  = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];
    else
        cfg.inputfile   = cfg.files.raw_mat;
        cfg.outputfile  = cfg.files.raw_filtered;
    end
    
    %% Filter
    % Lange (2015): 0.2-30 Hz bandpass
    
    cfg.reref           = 'yes';
    cfg.refchannel      = 'all';
    cfg.refmethod       = 'avg';
    
    cfg.padding = 5;
    if only_demean
        cfg.demean      = true;
    elseif ICA
        cfg.hpfilter    = 'yes';
        cfg.hpfreq      = 0.1;
        cfg.hpfilttype  = 'firws';
        cfg.hpfiltwintype = 'kaiser';

        cfg.lpfilter    = 'yes';
        cfg.lpfreq      = 30;
        cfg.lpfilttype  = 'firws'; 
        cfg.lpfiltwintype = 'kaiser';
    else
        cfg.hpfilter    = 'yes';
        cfg.hpfreq      = 1;
        cfg.hpfilttype  = 'firws';
        cfg.hpfiltwintype = 'kaiser';

        cfg.lpfilter    = 'yes';
        cfg.lpfreq      = 60;
        cfg.lpfilttype  = 'firws'; 
        cfg.lpfiltwintype = 'kaiser';

        cfg.dftfilter   = 'yes';
    end
   
    ft_preprocessing(cfg);

end