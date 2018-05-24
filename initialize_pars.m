function pars = initialize_pars(pars)
    % Initialize paths from my_config:
    [pars.my_root, pars.my_data_folder] = my_config();

    % Create time stamp
    pars.time_stamp = now;
    pars.date_time = datetime('now');
end