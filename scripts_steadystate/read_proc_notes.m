function proc_data = read_proc_notes(ICA)
    [my_root, my_fieldtrip_path] = my_config();
    cfg                         = [];
    cfg.rootdir                 = [my_root filesep];
    cfg.datadir                 = [cfg.rootdir 'data' filesep 'Nicolet' filesep];
    
    if ICA
        [num, txt, raw] = xlsread('proc_notes_article.xlsx');
    else
        [num, txt, raw] = xlsread('proc_notes.xlsx');
    end
    
    for i = 2:17
        subjstr = raw{i,1};
        assign_data(2,'data_available');
        assign_data(3,'eyes_closed_start');
        assign_data(4,'eyes_closed_stop');
        assign_data(5,'eyes_open_start');
        assign_data(6,'eyes_open_stop');
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