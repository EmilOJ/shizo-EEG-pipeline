function [] = initialize_participant_data(participant) 
    [my_root, my_data_folder]  = my_config();
    
    cfg.dataset = [my_data_folder,filesep, participant ,filesep, participant '.e'];
    cfg.continuous = 'yes';
    
    % Read data
    data = ft_preprocessing(cfg);
    
    selectchannels = ft_channelselection({'all', '-25', '-EKG', '-Body Pos', '-CPAP', '-Pulse', '-Photic', '-Rate', '-IBI', '-Bursts', '-Suppr'}, data.label);
    data = ft_selectdata(data, 'channel', selectchannels);
    
    save([my_data_folder, filesep, participant ,filesep,'data_init.mat'], 'data');
end