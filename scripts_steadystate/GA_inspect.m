function [] = GA_inspect(experiment, channels)
   ;
   cfg = initialize_participant_cfg(experiment, 2);
   
   standardball = load([cfg.ERPdir 'standardball_GA.mat']);
   oddball = load([cfg.ERPdir 'oddball_GA.mat']);
   
   
  
    %% GA butterfly
   figure;
   for j = 1:2
       if j == 1
           plot_title = 'Standardball condition';
           y = standardball.grandavg.avg;
           time = standardball.grandavg.time;
       else
           plot_title = 'Oddball condition';
           y = oddball.grandavg.avg;
           time = oddball.grandavg.time;
       end
       subplot(2,1,j);
       
       for i=1:size(y,1)
           plot(time, y(i,:))% - y(i,1));%-mean(y(i,:),2));
           hold on;
       end
       axis tight;
       %Baseline correction
%        if strcmp(alignment, 'stim')
%            xlim([2 3]);
%        end
%        ylim([-2 2])
       ylim([-5 6]);
       title(plot_title);
       hold off;
       grid on;
       set(gca,'Ydir','reverse');
       xlabel('time [s]');
   end

   
%    
%    cfg.showlabels  = 'yes';
% %    cfg.layout      = 'biosemi128.lay';
%    
%    legend('gram','lex');
%    cfg.showlabels  = 'yes';
% %    cfg.layout      = 'biosemi128.lay';
%    %Baseline correction
% %    if strcmp(alignment, 'stim')
% %     cfg.xlim        = [2 3];
% %    end
%    figure; ft_multiplotER(cfg, standardball.grandavg, oddball.grandavg);
%    legend('standardball','oddball');
   
   figure; counter = 1;
   for chan = channels
       subplot(length(channels),1,counter);
       cfg.channel = chan;
       ft_singleplotER(cfg, standardball.grandavg, oddball.grandavg);
       set(gca,'Ydir','reverse');
       legend('standardball','oddball');
       counter = counter + 1;
   end
   
   clear standardball;
   clear oddball;
   
 
    
   
   
end