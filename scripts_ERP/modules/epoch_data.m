function [data] = epoch_data(pars, data)
    cfg = [];
    cfg.trialfun = 'oddball_trialfun'; 
    cfg.dataset = data;
    
    cfg = merge_pars_with_cfg(pars, cfg, 'epoch_data');

    for condition = {'standardball', 'oddball'}
        
        cfg.condition = condition{1};
        cfg    = ft_definetrial(cfg);
        
        data = ft_redefinetrial(cfg);
    end
end