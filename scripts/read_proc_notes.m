function proc_data = read_proc_notes(experiment)
    %%%
    % Input:
    %   experiment: ERP or steady_state
    %
    % Output:
    %   proc_data: MATLAB struct representing proc_data excel sheet
    %%%
    
    %% TODO: Decide on a proper place for proc_notes
    [num, txt, raw] = xlsread([fileparts(which(mfilename)) filesep 'proc_notes_' [experiment]'.xlsx']);

    for i = 2:17
        subjstr = raw{i,1};
        if strcmp(experiment, 'ERP')
            assign_data(2,'data_available');
            assign_data(3,'standardball_range');
            assign_data(4,'oddball_range');
            assign_data(5,'bad_trials_standardball');
            assign_data(6,'bad_trials_oddball');
        elseif strcmp(experiment, 'steady_state')
            assign_data(2,'data_available');
            assign_data(3,'eyes_closed_start');
            assign_data(4,'eyes_closed_stop');
            assign_data(5,'eyes_open_start');
            assign_data(6,'eyes_open_stop');
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
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = value;
                else
                    proc_data.(subjstr).(name) = value;
                end
                
            elseif ischar(value)
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = str2num(value);
                else
                    proc_data.(subjstr).(name) = str2num(value);
                end
            else
                if iscell(name)
                    proc_data.(subjstr).(name{1}).(name{2}) = [];
                else
                    proc_data.(subjstr).(name) = [];
                end
            end
        elseif strcmp(type, 'c')
            if ~isnan(value)
                proc_data.(subjstr).(name{1}).(name{2}) = strsplit(value,',');
            else
                proc_data.(subjstr).(name{1}).(name{2}) = {};
            end
        end
            
    end
end