function [] = GA_inspect(pars)
   standardball = load([pars.my_data_folder filesep 'GA_standardball.mat']);
   oddball = load([pars.my_data_folder filesep 'GA_oddball.mat']);
   
   cfg.channels = {'Fp1';'Fp2';'F3';'F4';'C3';'C4';'P3';'P4';'O1';'O2';'F7';'F8';'T7';'T8';'P7';'P8';'T9';'T10';'Fz';'Cz';'Pz';'F10';'F9';'P9';'P10'};
   
   cfg = merge_pars_with_cfg(pars, cfg, 'GA_inspect');
  
    %% GA butterfly
   figure;
   for j = 1:2
       if j == 1
           plot_title = 'Standardball condition';
           y = standardball.grand_average.avg;
           time = standardball.grand_average.time;
       else
           plot_title = 'Oddball condition';
           y = oddball.grand_average.avg;
           time = oddball.grand_average.time;
       end
       subplot(2,1,j);
       
       for i=1:size(y,1)
           plot(time, y(i,:) - y(i,1) );%-mean(y(i,:),2));
           hold on;
       end
       axis tight;
       %Baseline correction
%        if strcmp(alignment, 'stim')
%            xlim([2 3]);
%        end
%        ylim([-2 2])
       ylim([-12 12]);
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
%    
%    figure; counter = 1;
%    for chan = cfg.channels
%        subplot(length(cfg.channels),1,counter);
%        cfg.channel = chan;
%        ft_singleplotER(cfg, standardball.grand_average, oddball.grand_average);
%        set(gca,'Ydir','reverse');
%        legend('standardball','oddball');
%        counter = counter + 1;
%    end
%    
%    clear standardball;
%    clear oddball;
%    
 
    
   
   
end