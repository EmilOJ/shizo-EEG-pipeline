function initialize_paths(pars)
addpath(genpath([pars.my_root,filesep,'scripts']))
addpath(genpath([pars.my_root,filesep,'scripts_ERP']))
addpath(genpath([pars.my_root,filesep,'scripts_steadystate']))
addpath([pars.my_root,filesep,'mpm',filesep,'mpm-packages',filesep,'fieldtrip'])