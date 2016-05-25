clc;
close all;
clear;

% If the global variables aren't first declared outside of the the UI
% script they don't become global at all. Kind of stupid actually.
run('declare_flags');

global UI_MODE
global SAVE_FIG_FLAG
global VISUALIZE_DATA_FLAG
global DATASET_PATH
global REFERENCE_PATH

% Construct a questdlg with two options
choice = questdlg('Which one would you like to run?', 'PR 2015/16', 'Custom Simulation','All Simulations', 'Interesting Simulations','Custom Simulation');

% Handle response
switch choice
    case 'Custom Simulation'
        
        UI_MODE = 1;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 1;
        REFERENCE_PATH = '../images/custom_simulations';
        
        run('main_UI');
        
    case 'All Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        DATASET_PATH = '../data/dataset.mat';
        REFERENCE_PATH = '../images/all_simulations';
        
        run('run_all');
        
    case 'Interesting Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        DATASET_PATH = '../data/dataset.mat';
        REFERENCE_PATH = '../images/interesting_simulations';
        
        run('run_interesting');
        
end