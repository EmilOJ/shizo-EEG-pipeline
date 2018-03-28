clc; close all; clear all;
add_filedtrip_path()

experiment = 'oddball';
participants = {...
%     '1001'
%     '1003'
%     '1004'
%     '1005'
%     '1006'
    '1007'
    '1008'
    '1009'
    '1011'
    '1012'
    '1014'    
};
    
ICA = false;


for i = 1:length(participants)
    participant = participants(i);
    participant = participant{1}
    disp(['Processing participant ' participant '...']);
    cfg = initialize_participant_cfg(experiment, participant, ICA);
    
    if ~cfg.proc_data.(cfg.subjectstr).data_available
        continue
    end

    %% Read data
    initialize_participant_data(experiment, participant , ICA); 

    %% Filter
    my_filter(experiment, participant , ICA);

    %% Epoch data
    epoch_data_1s(experiment, participant , ICA);

    %% Reject artifacts
%     reject_artifacts_manual(experiment, participant, ICA);

    
end

%% Grand average
    subjects = {...
    '1001'
    '1003'
    '1004'
    '1005'
    '1006'
    '1007'
    '1008'
    '1009'
    '1011'
    '1012'
    '1014'    
    };
    % subjects = [14,13,5,16,15,17,21,12,8,25]% slowest
    % subjects = [23,25]

    grand_average(experiment, subjects);
    % grand_average(experiment, subjects, 'stim');

    GA_inspect(experiment, {'C21', 'A1', 'A23', 'D31'});
    % GA_inspect(experiment, {'C21', 'A1', 'A23', 'D31'}, 'stim');

    %% 