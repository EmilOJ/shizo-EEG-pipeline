clear all; clc; close all;

pars = struct;
[pars.my_root, pars.my_data_folder] = my_config();

pars.conditions = {
    'standardball'
    'oddball'
};

pars.participants = {
%     's1001'
    's1003'
%     's1004'
%     's1005'
%     's1006'
%     's1007'
%     's1008'
%     's1009'
%     's1010'
%     's1011'
%     's1012'
%     's1013'
%     's1014'
%     's1015'
%     's1016'
%         's1017'
%         's1018'
%         's1019'
%         's1020'
%         's1021'
%         's1022'
%         's1023'
%         's1024'
};

grand_average(pars);

GA_inspect(pars)
% saveas(1, [pars.participants{1} '.svg'],'svg');





    