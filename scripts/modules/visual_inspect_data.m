function [data] = visual_inspect_data(pars, data)
    cfg.preproc.hpfilter        = 'yes';
    cfg.preproc.hpfreq          = 0.1;
    cfg.preproc.hpfilttype      = 'firws';
    cfg.preproc.hpfiltwintype   = 'kaiser';
    cfg.preproc.hpfiltord       = 4530;
    
    cfg.channel            = 'all';
    cfg.continuous         = 'yes';
    cfg.blocksize           = 20; %seconds
    cfg.ylim                = [-17 17];
    cfg.viewmode            = 'vertical';
    
    cfg = merge_pars_with_cfg(pars, cfg, 'visual_inspect_data');
    
    ft_databrowser(cfg,data);
end