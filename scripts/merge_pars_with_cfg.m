function [cfg] = merge_pars_with_cfg(pars, cfg, module_name)
% Merges pars with cfg for the specified module_name
if isfield(pars,module_name)
    names = fieldnames(pars.(module_name)); %names of all the parameters for this function
    
    for ipar = 1: length(names) %go trough all of them
        par_name = names{ipar};
        par_val = pars.(module_name).(par_name);
        cfg.(par_name) = par_val;
    end
else
    warning('off', 'backtrace');
    warning(['No pars defined for module ', module_name '. Using default parameters.']);
    warning('on', 'backtrace');
end