function [data_output] = epoch(pars, data)
    cfg = [];
    cfg.trialfun = 'oddball_trialfun'; 
    cfg.dataset = [pars.subject_data_dir, filesep , pars.participant, '.e'];
    cfg.pars = pars;
    
    cfg = merge_pars_with_cfg(pars, cfg, 'epoch');
    
    data_output = struct;
    
    for condition = {'standardball', 'oddball'}
        
        cfg.condition = condition{1};
        cfg_trl    = ft_definetrial(cfg);
        
        data_output.(condition{1}) = ft_redefinetrial(cfg_trl, data);
    end
end