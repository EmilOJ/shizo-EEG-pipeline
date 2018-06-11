function [data] = ke_filter(pars, data)
    cfg = [];
   
    cfg.hpfilter        = 'yes';
    cfg.hpfreq          = 0.1;
    cfg.hpfilttype      = 'firws';
    cfg.hpfiltwintype   = 'kaiser';
    
    cfg.lpfilter        = 'yes';
    cfg.lpfreq          = 105;
    cfg.lpfilttype      = 'firws'; 
    cfg.lpfiltwintype   = 'kaiser';

    cfg.dftfilter   = 'yes';
    
    cfg = merge_pars_with_cfg(pars, cfg, 'ke_filter');
   
    data = ft_preprocessing(cfg, data);
end