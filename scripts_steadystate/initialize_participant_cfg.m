function [cfg] = initialize_participant_cfg(experiment, participant, ICA)
    if nargin < 3
        ICA = false;
    end
    
    [my_root, my_fieldtrip_path, my_output_folder] = my_config();
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.subjectnr               = participant;
    cfg.subjectstr              = ['s' cfg.subjectnr];
    cfg.datadir                 = [cfg.rootdir 'roskilde-eeg-pipeline/data' filesep 'Nicolet' filesep];
    cfg.datadir_processed       = [my_output_folder filesep];
    cfg.subjectdir              = [cfg.datadir cfg.subjectnr filesep];
    cfg.experiment              = experiment;
    cfg.subjectdir_processed    = [cfg.datadir_processed cfg.subjectnr filesep];
    if ~exist(cfg.datadir_processed, 'dir') 
        mkdir(cfg.rootdir, 'steadystate');
    end
    if ~exist(cfg.subjectdir_processed, 'dir') 
        mkdir(cfg.datadir_processed, num2str(cfg.subjectnr));
    end
    cfg.proc_data               = read_proc_notes(ICA);
  
    cfg.files.raw               = [cfg.subjectdir cfg.subjectnr '.e'];
    cfg.files.raw_mat           = [cfg.subjectdir_processed cfg.subjectstr '.mat'];
    cfg.files.raw_filtered      = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered.mat'];
    cfg.files.raw_filtered_      = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered_'];
    cfg.files.raw_filtered_epoched = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered_epoched_' cfg.experiment '.mat'];
    cfg.files.raw_filtered_epoched_spectral = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered_epoched_' cfg.experiment '_spectral.mat'];
    cfg.files.raw_filtered_artifacts_rejected      = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered_artifacts_rejected.mat'];
    cfg.files.raw_filtered_artifacts_rejected_      = [cfg.subjectdir_processed cfg.subjectstr '_raw_filtered_artifacts_rejected_'];
    
    cfg.files.ICA_pruned        = [cfg.subjectdir_processed cfg.subjectstr '_ICApruned.mat'];
    cfg.files.ICA_pruned_filtered = [cfg.subjectdir_processed cfg.subjectstr '_ICApruned_filtered.mat'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_ = [cfg.subjectdir_processed cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_'];
    cfg.files.ICA_pruned_filtered_artifacts_rejected_interpolated_ = [cfg.subjectdir_processed cfg.subjectstr '_ICA_pruned_filtered_artifacts_rejected_interpolated_'];
    cfg.files.ICA_pruned_filtered_ = [cfg.subjectdir_processed cfg.subjectstr '_ICApruned_filtered_'];
end