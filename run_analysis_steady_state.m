clear all; clc; close all;

pars = struct;
[pars.my_root, pars.my_data_folder] = my_config();

pars.conditions = {
    'eyes_closed'
    'eyes_open'
};

pars.participants = {
    's1001'
    's1003'
    's1004'
%     's1005' % Control
    's1006'
    's1007'
%     's1008' % Control
    's1009'
    's1010'
    's1011'
    's1012'
    's1013'
    's1014'
    's1015'
    's1016'
        's1017'
        's1018'
        's1019'
        's1020'
%         's1021' % Control % Unavailable
%         's1022' % Control
        's1023'
        's1024'
};

% spectral_grand_average(pars);
visualize_powerspectra(pars);

% close all;
% pars.visualize_powerspectra.range_freq = [0 300];
% pars.visualize_powerspectra.freqrange = [1, 4]; %Hz
% pars.visualize_powerspectra.freqname = 'delta'; %Hz
% visualize_powerspectra(pars);
% saveas(1, 'full_spectrum_patient.png','png');
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 50];
% pars.visualize_powerspectra.freqrange = [4, 7]; %Hz
% pars.visualize_powerspectra.freqname = 'theta'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 20];
% pars.visualize_powerspectra.freqrange = [8, 13]; %Hz
% pars.visualize_powerspectra.freqname = 'alpha'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 5];
% pars.visualize_powerspectra.freqrange = [12, 30]; %Hz
% pars.visualize_powerspectra.freqname = 'beta'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 1.4];
% pars.visualize_powerspectra.freqrange = [30, 45]; %Hz
% pars.visualize_powerspectra.freqname = 'low gamma'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 1.4];
% pars.visualize_powerspectra.freqrange = [55, 95]; %Hz
% pars.visualize_powerspectra.freqname = 'high gamma'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_patient_' pars.visualize_powerspectra.freqname '.png'],'png');




%% control
close all;
% pars.visualize_powerspectra.range_freq = [0 20];
% pars.visualize_powerspectra.freqrange = [1, 4]; %Hz
% pars.visualize_powerspectra.freqname = 'delta'; %Hz
% visualize_powerspectra(pars);
% saveas(1, 'full_spectrum_control.png','png');
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');
% 
% close all;
% pars.visualize_powerspectra.range_freq = [0 5];
% pars.visualize_powerspectra.freqrange = [4, 7]; %Hz
% pars.visualize_powerspectra.freqname = 'theta'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');
% 
% close all;
% pars.visualize_powerspectra.range_freq = [0 5];
% pars.visualize_powerspectra.freqrange = [8, 13]; %Hz
% pars.visualize_powerspectra.freqname = 'alpha'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');

% close all;
% pars.visualize_powerspectra.range_freq = [0 1];
% pars.visualize_powerspectra.freqrange = [12, 30]; %Hz
% pars.visualize_powerspectra.freqname = 'beta'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');
% 
% close all;
% pars.visualize_powerspectra.range_freq = [0 0.2];
% pars.visualize_powerspectra.freqrange = [30, 45]; %Hz
% pars.visualize_powerspectra.freqname = 'low gamma'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');
% 
% close all;
% pars.visualize_powerspectra.range_freq = [0 0.2];
% pars.visualize_powerspectra.freqrange = [55, 95]; %Hz
% pars.visualize_powerspectra.freqname = 'high gamma'; %Hz
% visualize_powerspectra(pars);
% saveas(2, ['topo_control_' pars.visualize_powerspectra.freqname '.png'],'png');






    