clc; close all; clear all;
tic;
pars = struct;

%% Custom settings
pars.participant = 's1003';

%% Initialization
[pars, data] = init_pipeline(pars);

%% Run one-timer
ICA_inspect_components(pars);
visual_inspect_data(pars, data);

%% Helper functions
function [pars, data] = init_pipeline(pars)
    disp('*** Initializaing pipeline... ***');
    % Parameters
    pars = initialize_pars(pars);

    % Data
    init_data(pars);
    
    disp('*** Loading data... ***');
    data = importdata([pars.subject_data_dir,filesep,'data_init.mat']);
end

function [] = init_data(pars)
    if exist([pars.subject_data_dir ,filesep,'data_init.mat']) == 0
       disp(['*** data_init.mat does not exist in ',pars.subject_data_dir ' ***']);
       disp('*** Creating it now... ***');
       initialize_participant_data(pars.participant);
    end
end