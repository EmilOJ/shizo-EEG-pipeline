function [data] = rereference(pars, data)
    cfg = [];
    cfg.reref = 'yes';
    cfg.refmethod = 'avg';
    if ~isfield(pars,'experiment')
        error('Missing parameter experiment')
    end
    if ~isfield(pars,'participant')
        error('Missing parameter participant')
    end
    cfg.refchannel = get_channellist(pars.experiment,pars.participant);
    cfg.channel = get_channellist(pars.experiment,pars.participant);
    
    cfg = merge_pars_with_cfg(pars, cfg, 'rereference');
    
    data = ft_preprocessing(cfg, data);
end