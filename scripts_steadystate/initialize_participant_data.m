function [] = initialize_participant_data(experiment, participant, ICA) 
    %cfg = initialize_participant_cfg(experiment, participant, ICA);
    [my_root, my_output_folder, my_data_folder]  = my_config()
    cfg.dataset = [my_data_folder,filesep,'1001',filesep,'1001.e'];
    cfg.continuous = 'yes';
    data = ft_preprocessing(cfg);
    
    selectchannels = ft_channelselection({'all', '-25', '-EKG', '-Body Pos', '-CPAP', '-Pulse', '-Photic', '-Rate', '-IBI', '-Bursts', '-Suppr'}, data.label);
    data = ft_selectdata(data, 'channel', selectchannels);
    
    save([my_data_folder,filesep,'1001',filesep,'data_init.mat'], 'data');
end