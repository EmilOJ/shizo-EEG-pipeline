function data = get_latest_data(pars, participant)    
    subject_data_dir = [pars.my_data_folder, filesep, participant];
    dirs = dir(subject_data_dir);
    filenames = {dirs.name};
    
    data_idx = find(cellfun(@(x) contains(x, 'data') && contains(x, 'final'), {dirs.name}));
    load([subject_data_dir filesep filenames{data_idx}]);
end

