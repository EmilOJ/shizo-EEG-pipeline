function [bad_trials_standardball, bad_trials_oddball] = get_triallist(pars)
    proc_data = read_proc_notes(pars);
        
    bad_trials_standardball = proc_data.(pars.participant).bad_trials_standardball;
    bad_trials_oddball = proc_data.(pars.participant).bad_trials_oddball;
end
