function [data] = rereference(pars, data)
    cfg = [];
    cfg.reref = 'yes';
    cfg.refmethod = 'avg';
    cfg.refchannel = get_channellist();
    cfg.channel = get_channellist();
    
    merge_pars_with_cfg(pars, cfg, 'rereference');
    
    data = ft_preprocessing(cfg, data);
end