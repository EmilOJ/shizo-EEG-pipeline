function [] = reject_artifacts_manual(experiment, participant, ICA)
    add_filedtrip_path();
    
    
    for condition = {'standardball', 'oddball'}
        icondition = condition{1};
        cfg = initialize_participant_cfg(experiment, participant, ICA);
        if ICA
            cfg.inputfile = [cfg.files.ICA_pruned_filtered_ icondition];
        else
            cfg.inputfile = [cfg.files.raw_filtered_artifacts_rejected_ icondition];
        end


        cfg.method   = 'summary';
%         cfg.outputfile = [cfg.files.ICA_pruned_filtered_artifacts_rejected_ icondition];
        data_clean   = ft_rejectvisual(cfg);
    end
    

end

