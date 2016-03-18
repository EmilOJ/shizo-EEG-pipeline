function [cfg] = initialize_participant_cfg(experiment, participant)
    eval('setroot')
    cfg                         = [];
    cfg.rootdir                 = [root filesep];
    cfg.subjectnr               = num2str(participant);
    cfg.subjectstr              = ['part' cfg.subjectnr];
    cfg.dataset                 = [cfg.subjectstr '.bdf'];
    cfg.datadir                 = [cfg.rootdir 'EEG-' experiment filesep];
end