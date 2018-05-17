function channels = get_channellist(experiment, participant)
    proc_data = read_proc_notes(experiment);
    channels = {'Fp1';'Fp2';'F3';'F4';'C3';'C4';'P3';'P4';'O1';'O2';'F7';'F8';'T7';'T8';'P7';'P8';'T9';'T10';'Fz';'Cz';'Pz';'F10';'F9';'P9';'P10'};
    
    
    bad_channels = proc_data.(participant).bad_channels;
    
    for i = 1:length(bad_channels)
        channels = channels(~strcmp(channels, bad_channels(i)));
    end
    
    if ~isempty(bad_channels)
        disp(['Channels removed:' bad_channels]);
    else
        disp('No bad channels were removed');
    end
end
