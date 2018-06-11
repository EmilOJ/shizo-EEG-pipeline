function [] = ICA_inspect_components(pars)
    %%%
    % Visualizes ICA components and corresponding time-domain data for
    % artifact identification. Components containing only artifacts should
    % be notes in the corresponding proc_notes file.
    %
    % Input: 
    %   pars: Parameter file
    %   ICA_components: Output of ICA_decomposition()
    %
    % Optional parameters:
    %   pars.component  
    %   pars.channel
    %   pars.blocksize
    %%%
    
    load([pars.subject_data_dir, filesep, 'data_out_module_', 'ICA_decomposition','.mat']);
    
    % Topoplot config
    cfg.component = [1:20]; % Components to show
    cfg.layout      = get_layout();
    cfg.comment     = 'no';
    
%     % Databrowser config
%     cfg.channel     = [1:5];
%     cfg.viewmode    = 'component';
%     cfg.continuous  = 'yes';
%     cfg.blocksize   = 10; %seconds
    
    cfg = merge_pars_with_cfg(pars, cfg, 'ICA_inspect_components');
    
    ft_topoplotIC(cfg, ICA_components); % Plot components
    
    ft_databrowser(cfg, ICA_components);
end