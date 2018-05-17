function pars = initialize_pars(varargin)
%pair wise input for parameters for example: initialize_pars('experiment','eyes-closed','participant','1001')
pars.experiment = 'eyes-closed';
pars.participant = '1001';
%Names of the moduels in the order they should be run.
pars.module_order= {'module1','module2','module3'} ;

% Here we initialize parameters for all the modules that we will be using
% for each different module. The parameters should be saved as: pars.["name
% of function"].["parameter name that the given function accepts as input"]
% = somevalue

%spectral_analysis
pars.spectral_analysis.par1 = 'somevalue';
pars.spectral_analysis.experiment = 'yoyo';
pars.spectral_analysis.ICA ='false';

%initialize paths from my_config:
[pars.my_root, pars.my_output_folder, pars.my_data_folder] = my_config();

%create time stamp
pars.time_stamp = now;
pars.date_time = datetime('now');
for i =1:2:length(varargin)
        pars.(varargin{i}) = varargin{i+1};
end