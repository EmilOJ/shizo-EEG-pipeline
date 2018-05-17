function data = test_func2(pars,data)

% cfg = initialize_participant_cfg(pars.experiment, pars.participant, pars.ICA);
%cfg.inputfile = cfg.files.raw_filtered_epoched;
% cfg.outputfile = cfg.files.raw_filtered_epoched_spectral;

%here wedefine default parameters
cfg.par1       = 1;
cfg.par2      = 2;
cfg.par3          = 3;

%here we overwrite default parameters if the parameter is defined in pars
names = fieldnames(pars.test_func2); %names of all the parameters for this function
for ipar = 1: length(names) %go trough all of them
    par_name = names{ipar};
    par_val = pars.test_func2.(par_name);
    cfg.(par_name) = par_val;
end

data = data.*cfg.par1;
end