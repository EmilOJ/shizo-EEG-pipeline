function [comps] = get_ICA_comps_to_reject(pars)
    proc_data = read_proc_notes(pars);
    comps = proc_data.(pars.participant).ICA_EOG;
end

