function [bad_trials_standardball, bad_trials_oddball] = get_triallist(experiment, participant)
    proc_data = read_proc_notes(experiment);
        
    bad_trials_standardball = proc_data.(participant).bad_trials_standardball;
    bad_trials_oddball = proc_data.(participant).bad_trials_oddball;
end
