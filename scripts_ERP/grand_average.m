function [] = grand_average(pars, data)
   
   cfg = initialize_participant_cfg(experiment, '1001');
    
   counter = 1;
   for i = 1:length(subjects)
       subject = subjects{i};
       
           avg_standardball{counter} = compute_ERP_avg(experiment, subject, 'standardball');
           avg_oddball{counter} = compute_ERP_avg(experiment, subject, 'oddball');
           counter = counter +1 ;
      
   end
   
   save([cfg.ERPdir 'standardball_averages.mat'], 'avg_standardball');
   save([cfg.ERPdir 'oddball_averages.mat'], 'avg_oddball');
   
 
   
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


   
   cfg.outputfile = [cfg.ERPdir 'standardball_GA.mat'];
   ft_timelockgrandaverage(cfg, avg_standardball{:});
   
   cfg.outputfile = [cfg.ERPdir 'oddball_GA.mat'];
   ft_timelockgrandaverage(cfg, avg_oddball{:});
   
end
