function data = spectral_analysis(pars, experiment, participant, ICA)
if ~isfield(pars.spectral_analysis,'experiment')
    error(['Error in Spectral_analysis: parameter ''experiment'' not found'])
end
if ~isfield(pars.spectral_analysis,'experiment')
    error(['Error in Spectral_analysis: parameter ''participant'' not found'])
end
if ~isfield(pars.spectral_analysis,'ICA')
    error(['Error in Spectral_analysis: parameter ''ICA'' not found'])
end
% cfg = initialize_participant_cfg(pars.experiment, pars.participant, pars.ICA);
%cfg.inputfile = cfg.files.raw_filtered_epoched;
% cfg.outputfile = cfg.files.raw_filtered_epoched_spectral;

%     cfg.method       = 'mtmconvol';
cfg.method       = 'mtmfft';
cfg.taper        = 'hanning';
cfg.foi          = 1:0.1:60;

%here we initialize our parametersinto the config files
names = fieldnames(pars.spectral_analysis); %names of all the parameters for this function
for ipar = 1: length(names) %go trough all of them
    par_name = names{ipar};
    par_val = pars.spectral_analysis.(par_name);
    eval(['cfg.',par_name,' = ' ,'''',par_val,''';']) %assigning par value to a new variable with par_name
    %pars.spectral_analysis.(str)
end
% analysis 2 to 30 Hz in steps of 2 Hz
%     cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;   % length of time window = 0.5 sec
% %     cfg.toi          = -0.5:0.05:1.5;                  % time window "slides" from -0.5 to 1.5 sec in steps of 0.05 sec (50 ms)
%     cfg.toi = 'all';
%     cfg.pad = 'nextpow2';
ft_freqanalysis(cfg);
data = importdata(cfg.outputfile);
end