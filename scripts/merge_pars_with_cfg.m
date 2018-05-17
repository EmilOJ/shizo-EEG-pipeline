function [cfg] = merge_pars_with_cfg(pars, cfg, module_name)
    % Merges pars with cfg for the specified module_name

    names = fieldnames(pars.(module_name)); %names of all the parameters for this function
    
    for ipar = 1: length(names) %go trough all of them
        par_name = names{ipar};
        par_val = pars.(module_name).(par_name);
        cfg.(module_name).(par_name) = par_val;
    end
end