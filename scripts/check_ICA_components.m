function [] = check_ICA_components(pars, ICA_components)
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
    
    cfg.component = [1:20]; % Components to show
    cfg.layout      = get_layout();
    cfg.comment     = 'no';
    % TODO: Read parameters from pars
    ft_topoplotIC(cfg, ICA_components); % Plot components
    
    cfg.channel     = [1:5];
    cfg.viewmode    = 'component';
    cfg.continuous  = 'yes';
    cfg.blocksize   = 10; %seconds
    % TODO: Read parameters from pars
    ft_databrowser(cfg, comp);

end