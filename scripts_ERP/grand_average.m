function [] = grand_average(pars)
   for icondition = 1:length(pars.conditions)
       averages_temp = struct;
       condition = pars.conditions{icondition};

       for i = 1:length(pars.participants)
           participant = pars.participants{i};
           data = get_latest_data(pars, participant);
           data = data.(condition);
           
           averages_temp.(participant) = compute_ERP_avg(pars, data);
       end
       
       cfg.channel = 'all';
       grand_average = ft_timelockgrandaverage(cfg, averages_temp.(participant));
       
       save([pars.my_data_folder filesep 'GA_' condition '.mat'], 'grand_average');
   end
   
   
%    % ANOVA
%     disp('calculating anova table');
%     anovas = zeros(128, length(EEG(1).times));
%     tic
%     for channel_i = 1:128
%         for sample_i = 1:EEG.pnts
%             test_groups = [[squeeze(epochs_gram(channel_i, sample_i,:)); NaN;], ...
%                 squeeze(epochs_lex(channel_i, sample_i,:))];
%             [anovas(channel_i, sample_i), tbl, stats] = anova1(test_groups, {'grammatical', 'lexical'}, 'off');
%         end
%     end
%     toc
%     %
%     anovas(anovas > 0.05) = 1;


end
