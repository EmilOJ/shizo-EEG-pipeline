clear all;

cfg = initialize_participant_cfg('1001', false);
cfg.dataset = cfg.files.raw;
hdr = ft_read_header(cfg.dataset);
events = ft_read_event(cfg.dataset);


