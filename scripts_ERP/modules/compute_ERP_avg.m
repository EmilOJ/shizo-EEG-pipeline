function [timelock] = compute_ERP_avg(pars, data)
    if ~isfield(pars,'experiment')
        error('Missing parameter experiment')
    end
    if ~isfield(pars,'participant')
        error('Missing parameter participant')
    end
    
    cfg = [];
    cfg.baseline = [-50 0];
    cfg.channel = get_channellist(pars.experiment, pars.participant);
    
    merge_pars_with_cfg(pars, cfg, 'compute_ERP_avg');

    timelock = ft_timelockanalysis(cfg, data);
    timelock = ft_timelockbaseline(cfg, timelock);
end
