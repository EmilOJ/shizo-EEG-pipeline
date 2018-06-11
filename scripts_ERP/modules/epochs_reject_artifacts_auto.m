function data = epochs_reject_artifacts_auto(pars, data)
    % SQUID jump artifact rejection
    % channel selection, cutoff and padding
    cfg.artfctdef.zvalue.channel    = get_channellist(pars);
    cfg.artfctdef.zvalue.cutoff     = 20;
    cfg.artfctdef.zvalue.trlpadding = 0;
    cfg.artfctdef.zvalue.artpadding = 0;
    cfg.artfctdef.zvalue.fltpadding = 0;

    % algorithmic parameters
    cfg.artfctdef.zvalue.cumulative    = 'yes';
    cfg.artfctdef.zvalue.medianfilter  = 'yes';
    cfg.artfctdef.zvalue.medianfiltord = 9;
    cfg.artfctdef.zvalue.absdiff       = 'yes';
    
    cfg.artfctdef.threshold.range      = 400;

    % make the process interactive
    cfg.artfctdef.zvalue.interactive = 'no';
    
    cfg.trl = data.trl;
    cfg = ft_artifact_zvalue(cfg, data);
    cfg = ft_artifact_threshold(cfg, data);
    
    data = ft_rejectartifact(cfg, data);
end

