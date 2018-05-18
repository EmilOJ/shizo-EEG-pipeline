function pars = initialize_pars(varargin)
% Pair wise input for parameters for example: initialize_pars('experiment','eyes-closed','participant','1001')

% Names of the moduels in the order they should be run.
% Example: 
 pars.module_order= {'rereference'} ;

% Initialize paths from my_config:
[pars.my_root, pars.my_output_folder, pars.my_data_folder] = my_config();

% Create time stamp
pars.time_stamp = now;
pars.date_time = datetime('now');

% Here we initialize parameters for all the modules that we will be using
% for each different module. The parameters should be saved as: pars.["name
% of function"].["parameter name that the given function accepts as input"]
% pars.reference= somevalue
for i =1:2:length(varargin)
        pars.(varargin{i}) = varargin{i+1};
end