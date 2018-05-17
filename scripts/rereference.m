function [data] = rereference(pars, data)
    cfg = [];
    cfg.reref = 'yes';
    cfg.refmethod = 'avg';
    cfg.refchannel = get_channellist();
    cfg.channel = get_channellist();
    
    %TODO: Add cfg from pars
    
    data = ft_preprocessing(cfg, data);
end