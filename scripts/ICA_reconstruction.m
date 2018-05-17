function [data] = ICA_reconstruction(pars, data, ICA_components)
    cfg.channel = get_channellist();
    
    %% Reconstruction from ICA components
    data = ft_rejectcomponent(cfg, ICA_components, data);
end