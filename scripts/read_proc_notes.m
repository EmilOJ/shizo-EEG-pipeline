function proc_data = read_proc_notes(pars)
    %%%
    % Input:
    %   experiment: ERP or steady_state
    %
    % Output:
    %   proc_data: MATLAB struct representing proc_data excel sheet
    %%%
    
    [my_root my_data_folder] = my_config();
    [num, txt, raw] = xlsread([my_data_folder filesep 'proc_notes.xlsx']);

    for i = 2:25
        subjstr = [raw{i,1}];
        if strcmp(pars.data_type, 'epoch')
            assign_data(2,'data_available');
            assign_data(3,'standardball_range');
            assign_data(4,'oddball_range');
            assign_data(5,'bad_trials_standardball');
            assign_data(6,'bad_trials_oddball');
            assign_data(7,'bad_channels', 'c');
            assign_data(8,'ICA_EOG');
        elseif strcmp(pars.data_type, 'continuous')
            assign_data(2,'data_available');
            assign_data(3,'eyes_closed_start');
            assign_data(4,'eyes_closed_stop');
            assign_data(5,'eyes_open_start');
            assign_data(6,'eyes_open_stop');
            assign_data(7,'bad_channels', 'c');
            assign_data(8,'ICA_EOG');
        else
            msgID = 'read_proc_notes:BadArgument';
            msg = 'experiement has to be either ERP og steady_state. Neither was provided';
            throw(MException(msgID, msg));
        end

    end
    
    
    function [] = assign_data(row, name, type)
        if nargin < 3
            type = 'num';
        end
        
        value = raw{i,row};
        
        if strcmp(type, 'num')   
            if isnumeric(value) & ~isnan(value)
                proc_data.(subjstr).(name) = value;
            elseif ischar(value)
                proc_data.(subjstr).(name) = str2num(value);
            else
                proc_data.(subjstr).(name) = [];
            end
        elseif strcmp(type, 'c')
            if ~isnan(value)
                proc_data.(subjstr).(name) = strtrim(strsplit(string(value),','));
            else
                proc_data.(subjstr).(name) = {};
            end
        end
            
    end
end