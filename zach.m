function [trl, event] = trialfun(cfg)

% read the header information
hdr           = ft_read_header(cfg.dataset);

data           = ft_read_data(cfg.dataset);

% read the events from the data
chanindx      = 1;
detectflank   = 'up';
threshold     = '(3/2)*nanmedian'; % or, e.g., 1/2 times the median for down flanks
ch_oddball = 28;
ch_ball = 29;

ch_oddball_diff = diff(data(ch_oddball,:));
ch_ball_diff = diff(data(ch_ball,:));

idx = find(ch_oddball_diff > 1e6)

% define trials around the events
trl           = [];
pretrig       = 1 * hdr.Fs; % e.g., 1 sec before trigger
posttrig      = 2 * hdr.Fs; % e.g., 2 sec after trigger
for i = 1:numel(event)
    offset    = -hdr.nSamplesPre;  % number of samples prior to the trigger
    trlbegin  = event(i).sample - pretrig;
    trlend    = event(i).sample + posttrig;
    newtrl    = [trlbegin trlend offset];
    trl       = [trl; newtrl]; % store in the trl matrix
end
