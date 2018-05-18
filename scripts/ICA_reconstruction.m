function [data] = ICA_reconstruction(pars, data, ICA_components)
    cfg.channel = get_channellist();
    
    cfg = merge_pars_with_cfg(pars, cfg, 'ICA_reconstruction');
    
    %% Reconstruction from ICA components
    data = ft_rejectcomponent(cfg, ICA_components, data);
end