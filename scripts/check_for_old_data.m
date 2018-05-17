function use_data_file = check_for_old_data(pars,current_module)
%Returns a 1 if there is old data_file that match current pars and 0 if not.

fn1 = [pars.my_data_folder,filesep,pars.participant,filesep,'data_out_module_',num2str(current_module),'.mat'];
fn2 = [pars.my_data_folder,filesep,pars.participant,filesep,'pars_used_for_module_',num2str(current_module),'.mat'];
use_data_file = 1;
if exist(fn1) == 0 || exist(fn2) == 0 % if any of the two files does not exist
    use_data_file = 0;
    return;
else
    pars_old = importdata(fn2);
end

%First we check to see if so far it has been the same module order up until this module, and if
%so we check if the same parameters were used in each step before this one.
for i_module = 1:current_module
    module_name = pars.module_order{i_module};
    module_name_old = pars_old.module_order{i_module};
    if ~strcmp(module_name,module_name_old)
        use_data_file = 0;
        return ;
    end
    
    % get parameter names used for module i
    if isfield(pars,module_name) == 0
        error(['Can''t find parameters for ',module_name])
    else
        names = fieldnames(pars.(module_name));
    end
    if isfield(pars_old,module_name) == 0
        use_data_file = 0;
        return ;
    else
        names_old = fieldnames(pars_old.(module_name));
    end
    
    %compare
    %are they the same length?
    if length(names)~=length(names_old)
        %if not:
        use_data_file = 0;
        return;
    else
        for i_name = 1:length(names)
            if ~strcmp(num2str(pars.(module_name).(names{i_name})), num2str(pars_old.(module_name).(names{i_name})))
                %we  use num2str on both values so they can be compared
                %them even if they are numbers
                use_data_file = 0;
                return;
            end
        end
    end
    
end






