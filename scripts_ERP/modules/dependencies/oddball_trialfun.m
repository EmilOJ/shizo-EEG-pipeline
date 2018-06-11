function [trl, event] = oddball_trialfun(cfg)
    disp('*** Reading header and event information ***');
    hdr   = ft_read_header(cfg.dataset);
    event = ft_read_event(cfg.dataset);
    
    disp('*** Reading original data ***');
    data = ft_read_data(cfg.dataset);
    
    disp(['*** Extracting ' cfg.condition ' trials... ***']);
        % Save the oddball or standardball channel
    [bad_trials_standardball, bad_trials_oddball] = get_triallist(cfg.pars);
    if strcmp(cfg.condition, 'standardball') 
        bad_trials = bad_trials_standardball;
        ball    = data(29,:);
        idx_range = 1:900;
    else
        bad_trials = bad_trials_oddball;
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
   
    latency  = cfg.latency; %s
    latency = round(latency * hdr.Fs); %convert to samples
    
    trl_begin = ballrisingindex + latency;
    trl_end = ballrisingindex + (cfg.trllength * hdr.Fs) + latency;
    
    offset = repmat(latency, length(ballrisingindex), 1);
    trl = [trl_begin' trl_end' offset];
    
    %% Remove previously rejected trials
    number_of_trials_to_reject = length(bad_trials);
    
    if number_of_trials_to_reject > 0
        trl(bad_trials,:) = [];
    end
end