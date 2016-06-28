function [] = epoch_data(experiment, participant, alignment)
    cfg = initialize_participant_cfg(experiment, participant);
    cfg_data = cfg;
    cfg_data.inputfile = cfg.files.ICA_pruned_filtered;
    data_org = ft_preprocessing(cfg_data);
    for alignment = {'stim', 'response'}
        for condition = {'gram', 'lex'}


            icondition = condition{1};
            cfg.condition = icondition;

            cfg.trialdef.eventcodes.det.gram = 65301;
            cfg.trialdef.eventcodes.det.lex = 65311;
            cfg.trialdef.eventcodes.verb.gram = [65421 65431 65422 65432];
            cfg.trialdef.eventcodes.verb.lex = [65521 65531 65522 65532];

            cfg.trialdef.eventtype  = 'STATUS';

            cfg.trialfun = 'my_trialfun'; 


            switch cfg.experiment
                case 'det' 
                    switch icondition
                        case 'gram'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.gram;
                        case 'lex'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.det.lex;
                    end

                case 'verber'
                    switch icondition
                        case 'gram'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.gram;
                        case 'lex'
                            cfg.trialdef.eventvalue = cfg.trialdef.eventcodes.verb.lex;
                    end
            end

            cfg.dataset = [cfg.subjectdir cfg.subjectstr '.bdf'];
            cfg.alignment = alignment{1};

            cfg.baselinewindow = [-2 -0.25]; % Set here for baseline correction

            cfg_cond    = ft_definetrial(cfg);
    %         cfg_cond.inputfile   = [cfg.subjectdir cfg.subjectstr '_ICApruned_filtered.mat'];           

            data   = ft_redefinetrial(cfg_cond,data_org);
            %figure; subplot(2,1,1); plot(data.trial{1}(1,:)); title(['First value: ' num2str(data.trial{1}(1,1))]);
            % Baseline correction
            cfg_b    = [];
            cfg_b.demean = 'yes';
            cfg_b.baselinewindow = cfg_cond.baselinewindow + (-cfg_cond.baselinewindow(1));
            cfg_b.outputfile   = [cfg_cond.subjectdir cfg_cond.subjectstr '_ICApruned_filtered_' icondition '_' alignment{1} '.mat'];
            data   = ft_preprocessing(cfg_b, data);
            %subplot(2,1,2); plot(data.trial{1}(1,:));
            


        end
    end
end