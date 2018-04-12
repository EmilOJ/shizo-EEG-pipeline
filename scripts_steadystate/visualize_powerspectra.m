function [] = visualize_powerspectra(experiment, participant, ICA)


freqvar = 'freq';
cfg_eyes_open = initialize_participant_cfg('eyes_open', participant, ICA);
cfg_eyes_closed = initialize_participant_cfg('eyes_closed', participant, ICA);

freq_eyes_closed = load(cfg_eyes_closed.files.raw_filtered_epoched_spectral, freqvar);
freq_eyes_closed = freq_eyes_closed.(freqvar)
freq_eyes_open = load(cfg_eyes_open.files.raw_filtered_epoched_spectral, freqvar);
freq_eyes_open = freq_eyes_open.(freqvar)

log_freq_eyes_closed = log(freq_eyes_closed.powspctrm);
log_freq_eyes_open = log(freq_eyes_open.powspctrm);

range_log_freq = [min(min(log_freq_eyes_closed(:)), min(log_freq_eyes_open(:))), max(max(log_freq_eyes_closed(:)), max(log_freq_eyes_open(:)))];

for i = 1:2
    if i == 1
        experiment = 'eyes_closed';
        freq_to_visualize = freq_eyes_closed;
    else
        experiment = 'eyes_open';
        freq_to_visualize = freq_eyes_open;
    end
    
    figure;
    subplot(2,1,1);
    colorplot = imagesc(freq_to_visualize.freq, 1:size(freq_to_visualize.label), log(freq_to_visualize.powspctrm));


    experiment_cell = split(experiment, '_');
    experiment_formatted = [experiment_cell{1} ' ' experiment_cell{2}]; 
    title(['Power Spectrum of condition "' experiment_formatted '"']);


    xlabel('Frequency [Hz]');
    ylabel('Channel');

    subplot(2,1,2);
    plot(freq_to_visualize.freq, log(freq_to_visualize.powspctrm'));
    xlabel('Frequency [Hz]');
    ylabel('log(Power)');
    ylim(range_log_freq)
end

load('layout2.mat');

range_freq = [min(min(freq_eyes_closed.powspctrm(:)), min(freq_eyes_open.powspctrm(:))), max(max(freq_eyes_closed.powspctrm(:)), max(freq_eyes_open.powspctrm(:)))];
range_freq = [0 5];

freq_eyes_closed_log = freq_eyes_closed;
freq_eyes_closed_log.powspctrm = log(freq_eyes_closed_log.powspctrm);
cfg = [];
cfg.xlim = [7.5 12.5];                
cfg.ylim = [1 2];                  
cfg.zlim = range_freq;           
cfg.baseline = 'no';
cfg.layout = lay;
cfg.marker = 'labels';
cfg.markerfontsize = 11;


figure; ft_topoplotTFR(cfg, freq_eyes_closed); colorbar
title('Eyes closed, ALPHA (7.5 - 12.5 Hz)');

freq_eyes_open_log = freq_eyes_open;
freq_eyes_open_log.powspctrm = log(freq_eyes_open_log.powspctrm);
cfg = [];
cfg.xlim = [7.5 12.5];                
cfg.ylim = [1 25];                  
cfg.zlim = range_freq;           
cfg.baseline = 'no';
cfg.layout = lay;

cfg.marker = 'labels';
cfg.markerfontsize = 11;


figure; ft_topoplotTFR(cfg, freq_eyes_open); colorbar
title('Eyes open, ALPHA (7.5 - 12.5 Hz)');