function [trl, event] = oddball_trialfun(cfg)
    disp(['Extracting ' cfg.condition ' trials...']);
    hdr   = ft_read_header(cfg.dataset);
    event = ft_read_event(cfg.dataset);
    
    data = ft_read_data(cfg.files.raw);
    
    % Save the oddball or standardball channel
    if strcmp(cfg.condition, 'standardball') 
        ball    = data(29,:);
        idx_range = 1:900;
    else
        ball    = data(28,:);
        idx_range = 1:100;
    end

    % Find all values over 2 volts
    ballthresh  = ball > 2e+6;
 
    % every change from 0 to 1 corresponding to a rising signal
    ballrising  = ...
        (ballthresh(1:end - 1) + ballthresh(2:end) == 1) ...
        & ballthresh(2:end);
    
    %find index for changes
    ballrisingindex     = find(ballrising);
    ballrisingindex     = ballrisingindex(idx_range);
    
    pretrig  = 0.2; %s
    posttrig = 0.7; %s
    
    pretrig = round(pretrig * hdr.Fs); %convert to samples
    posttrig = round(posttrig * hdr.Fs); %convert to samples

    trl_begin = ballrisingindex + pretrig; % + hdr.Fs*cfg.baselinewindow(1); %Baseline correction
    trl_end = ballrisingindex + posttrig;
    
    offset = repmat(pretrig, length(ballrisingindex), 1);
    trl = [trl_begin' trl_end' offset];
    
    %% Remove previously rejected trials 
    trials_to_reject = cfg.proc_data.(cfg.subjectstr).(['bad_trials_' cfg.condition]);
    number_of_trials_to_reject = length(trials_to_reject);
    
    if number_of_trials_to_reject > 0
        trl(trials_to_reject,:) = [];
    end
end