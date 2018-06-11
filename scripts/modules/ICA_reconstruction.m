function [data] = ICA_reconstruction(pars, data)
    cfg.channel = get_channellist(pars);
    
    % Load ICA components
    load([pars.subject_data_dir, filesep, 'data_out_module_', 'ICA_decomposition','.mat'], 'ICA_components');
    cfg.component = get_ICA_comps_to_reject(pars);
    
    cfg = merge_pars_with_cfg(pars, cfg, 'ICA_reconstruction');
    
    %% Reconstruction from ICA components
    data = ft_rejectcomponent(cfg, ICA_components, data);
end