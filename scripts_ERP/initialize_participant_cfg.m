function [cfg] = initialize_participant_cfg(experiment, participant, ICA)
    if nargin < 3
        ICA = false;
    end
    
    [my_root, my_fieldtrip_path] = my_config();
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.subjectnr               = participant;
    cfg.subjectstr              = ['s' cfg.subjectnr];
    cfg.datadir                 = [cfg.rootdir 'data' filesep 'Nicolet' filesep];
    cfg.subjectdir              = [cfg.datadir cfg.subjectnr filesep];
    cfg.ERPdir                  = [cfg.datadir 'ERP' filesep];
    cfg.proc_data               = read_proc_notes(ICA);
  
%     cfg.RTdir                   = [cfg.rootdir 'Behavioural-' experiment filesep 'all' filesep];
    cfg.experiment              = experiment;
%     cfg.ICAcomp_path            = [cfg.subjectdir cfg.subjectstr 'ICAcomp.mat'];
    
    cfg.files.raw               = [cfg.subjectdir cfg.subjectnr '.e'];
    cfg.files.raw_mat           = [cfg.subjectdir cfg.subjectstr '.mat'];
    cfg.files.raw_filtered      = [cfg.subjectdir cfg.subjectstr '_raw_filtered.mat'];
    cfg.files.raw_filtered_      = [cfg.subjectdir cfg.subjectstr '_raw_filtered_'];
    cfg.files.raw_filtered_artifacts_rejected      = [cfg.subjectdir cfg.subjectstr '_raw_filtered_artifacts_rejected.mat'];
    cfg.files.raw_filtered_artifacts_rejected_      = [cfg.subjectdir cfg.subjectstr '_raw_filtered_artifacts_rejected_'];
    
    cfg.files.ICA_pruned        = [cfg.subjectdir cfg.subjectstr '_ICApruned.mat'];
    cfg.files.ICA_pruned_filtered = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_ = [cfg.subjectdir cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ = [cfg.subjectdir cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_interpolated_'];
    cfg.files.ICA_pruned_filtered_ = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered_'];
end