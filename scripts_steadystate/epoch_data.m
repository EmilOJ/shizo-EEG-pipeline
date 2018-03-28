function [] = epoch_data(experiment, participant, ICA)
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    cfg_data = cfg;
    cfg_data.inputfile = cfg.files.raw_mat;
    
    cfg.trialfun = 'oddball_trialfun'; 

    cfg.dataset = cfg.files.raw;

    %cfg.baselinewindow = [-2 -0.25]; % Set here for baseline correction
    
    for condition = {'standardball', 'oddball'}
        
        cfg.condition = condition{1};
        

        cfg_cond    = ft_definetrial(cfg);

        if ICA
            cfg_cond.inputfile = cfg.files.ICA_pruned_filtered;
            cfg_cond.outputfile   = [cfg_cond.subjectdir cfg_cond.subjectstr '_ICApruned_filtered_' icondition '_' alignment{1} '.mat'];
        else
            cfg_cond.inputfile = cfg.files.raw_filtered;
            cfg_cond.outputfile   = [cfg.files.raw_filtered_artifacts_rejected_ condition{1} '.mat'];
        end

        ft_redefinetrial(cfg_cond);

        % Baseline correction
    %             cfg_b    = [];
    %             if strcmp(alignment,'stim')
    %                 cfg_b.demean = 'yes';
    %                 cfg_b.baselinewindow = cfg_cond.baselinewindow + (-cfg_cond.baselinewindow(1));
    %             end
    %             cfg_b       = [];
    %             cfg_b.reref = 'yes';
    %             cfg_b.refchannel = 1:128;
    %             cfg_b.channel = 1:128;
    % 
    %             
    %             cfg_b.outputfile   = [cfg_cond.subjectdir cfg_cond.subjectstr '_ICApruned_filtered_' icondition '_' alignment{1} '.mat'];
    %             data   = ft_preprocessing(cfg_b, data);
    %             subplot(2,1,2); plot(data.trial{1}(1,:));


    end
end