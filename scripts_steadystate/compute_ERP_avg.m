function [avg] = compute_ERP_avg(experiment, participant, condition, alignment)
    ;
    cfg = initialize_participant_cfg(experiment, participant);
    
    
    cfg1.inputfile = [cfg.files.raw_filtered_artifacts_rejected_ condition];
    avg = ft_timelockanalysis(cfg1);
%     
%     cfg = [];
%     cfg.baseline = [-300 -50];
%     
%     avg = ft_timelockbaseline(cfg, avg);
end
