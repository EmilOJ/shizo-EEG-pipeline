function [data] = reject_artifacts(pars, data)
    % Automatically rejects artifacts from epoched data using thresholding. 
    % `data` is assumed to be epoched already which means that `pars` must
    % contain a pars.trl field.
    
    if ~isfield(pars, 'trl')
        error(['Error in reject_artifacts: parameter ''trl'' not found'])
    end
    
    cfg = [];
    cfg.trl = pars.trl;
    cfg.continuous = 'no';
    
    % Thresholding artifact rejection
    cfg.artfctdef.threshold.channel = get_channellist();
    cfg.artfctdef.threshold.bpfilter  = 'yes';
    cfg.artfctdef.threshold.bpfreq    = [0.3 105];
    cfg.artfctdef.threshold.bpfiltord = 10;
    cfg.artfctdef.threshold.range = 400;     % µV
    [cfg, artifact_threshold] = ft_artifact_threshold(cfg, data);
    
    % Config for final artifact rejection
    cfg.artfctdef.threshold.artifact = artifact_threshold;
    
    % Final artifact rejection
    data = ft_rejectartifact(cfg, data);
end

