function channels = get_channellist(participant)
    channels = 1:24;
    bad_channels = cfg_epoch_1s.proc_data.(cfg_epoch_1s.subjectstr).bad_channel;

    for i = 1:length(bad_channels)
        channels = channels(channels ~= bad_channels(i));
    end
    disp(['Defining channels to remove:' mat2str(bad_channels)]);
end
