close all; 
figure(1);
subplot(2,1,1);
colorplot = imagesc(freq.freq, 1:size(freq.label), log(freq.powspctrm));
% set(colorplot, 'XData', freq.freq);
% set(gca,'XTick',freq.freq(1:2:end))



xlabel('Frequency [Hz]');
ylabel('Channel');

subplot(2,1,2);
plot(freq.freq, log(freq.powspctrm'));
xlabel('Frequency [Hz]');
ylabel('log(Power)');