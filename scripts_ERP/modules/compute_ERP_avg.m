function [timelock] = compute_ERP_avg(pars, data)
    cfg = [];
    cfg.channel = 'all';
    cfg.baseline = [0 1]; %Use first sample as baseline
    
    merge_pars_with_cfg(pars, cfg, 'compute_ERP_avg');

    timelock = ft_timelockanalysis(cfg, data);
    timelock = ft_timelockbaseline(cfg, timelock);
end