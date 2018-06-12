function [] = visualize_powerspectra(pars)

cfg.freqrange = [7.5 12.5];

cfg = merge_pars_with_cfg(pars, cfg, 'visualize_powerspectra');


freq_eyes_closed = importdata([pars.my_data_folder filesep 'GA_eyes_closed.mat']);
freq_eyes_closed = freq_eyes_closed;
freq_eyes_open = importdata([pars.my_data_folder filesep 'GA_eyes_open.mat']);
freq_eyes_open = freq_eyes_open;

log_freq_eyes_closed = log(freq_eyes_closed.powspctrm);
log_freq_eyes_open = log(freq_eyes_open.powspctrm);

range_log_freq = [min(min(log_freq_eyes_closed(:)), min(log_freq_eyes_open(:))), max(max(log_freq_eyes_closed(:)), max(log_freq_eyes_open(:)))];

figure;
for i = 1:2
    if i == 1
        experiment = 'eyes_closed';
        freq_to_visualize = freq_eyes_closed;
    else
        experiment = 'eyes_open';
        freq_to_visualize = freq_eyes_open;
    end
  
    subplot(2,2,i);
    colorplot = imagesc(freq_to_visualize.freq, 1:size(freq_to_visualize.label), log(freq_to_visualize.powspctrm));


    experiment_cell = split(experiment, '_');
    experiment_formatted = [experiment_cell{1} ' ' experiment_cell{2}]; 
    title(['Power Spectrum of condition "' experiment_formatted '"']);


    xlabel('Frequency [Hz]');
    ylabel('Channel');

    subplot(2,2,i+2);
    plot(freq_to_visualize.freq, (freq_to_visualize.powspctrm'));
    xlabel('Frequency [Hz]');
    ylabel('log(Power)');
%     ylim(range_log_freq)
end

set(gcf, 'Position', [100, 100, 1000, 600])

% range_freq = [min(min(freq_eyes_closed.powspctrm(:)), min(freq_eyes_open.powspctrm(:))), max(max(freq_eyes_closed.powspctrm(:)), max(freq_eyes_open.powspctrm(:)))];
% others
range_freq = cfg.range_freq;

% Delta
% range_freq = [0 20];

% low + high gamma
% range_freq = [0 0.2];

freq_eyes_closed_log = freq_eyes_closed;
freq_eyes_closed_log.powspctrm = log(freq_eyes_closed_log.powspctrm);
cfg1 = [];
cfg1.xlim = cfg.freqrange;                
cfg1.ylim = [1 2];                  
cfg1.zlim = range_freq;           
cfg1.baseline = 'no';
cfg1.layout = get_layout();
cfg1.marker = 'labels';
cfg1.markerfontsize = 11;

figure;
subplot(1,2,1); ft_topoplotTFR(cfg1, freq_eyes_closed); colorbar
title(['Eyes closed, ' cfg.freqname ' (' num2str(cfg.freqrange(1)) ' - ' num2str(cfg.freqrange(2)) ' Hz)']);

freq_eyes_open_log = freq_eyes_open;
freq_eyes_open_log.powspctrm = log(freq_eyes_open_log.powspctrm);
cfg2 = [];
cfg2.xlim = cfg.freqrange;                
cfg2.ylim = [1 25];                  
cfg2.zlim = range_freq;           
cfg2.baseline = 'no';
cfg2.layout = get_layout();

cfg2.marker = 'labels';
cfg2.markerfontsize = 11;


subplot(1,2,2); ft_topoplotTFR(cfg2, freq_eyes_open); colorbar
title(['Eyes open, ' cfg.freqname ' (' num2str(cfg.freqrange(1)) ' - ' num2str(cfg.freqrange(2)) ' Hz)']);

set(gcf, 'Position', [100, 100, 1000, 600])