pars = initialize_pars()

%Names of the moduels in the order they should be run.
pars.module_order= {'module1','module2','module3'} 

% Here we initialize parameters for all the modules that we will be using
% for each different module. The parameters should be saved as: pars.["name
% of function"].["parameter name that the given function accepts as input"]
% = somevalue

%spectral_analysis
pars.spectra_analysis.par1 = 'somevalue';

