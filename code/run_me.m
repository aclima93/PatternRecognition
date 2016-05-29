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

global NUM_ITERATIONS

% Construct a questdlg with two options
choice = questdlg('Which one would you like to run?', 'PR 2015/16', 'Custom Simulation','All Simulations', 'Interesting Simulations','Custom Simulation');

% Handle response
switch choice
    case 'Custom Simulation'
        
        UI_MODE = 1;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 1;
        REFERENCE_PATH = fullfile(pwd, '../results/custom_simulations');
        NUM_ITERATIONS = 1;
        
        run('main_UI');
        
    case 'All Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        DATASET_PATH = fullfile(pwd, '../data/dataset.mat');
        REFERENCE_PATH = fullfile(pwd, '../results/all_simulations');
        NUM_ITERATIONS = 3;
        
        run('run_all');
        
    case 'Interesting Simulations'
        
        UI_MODE = 0;
        SAVE_FIG_FLAG = 1;
        VISUALIZE_DATA_FLAG = 0;
        DATASET_PATH = fullfile(pwd, '../data/dataset.mat');
        REFERENCE_PATH = fullfile(pwd, '../results/interesting_simulations');
        NUM_ITERATIONS = 5;
        
        run('run_interesting');
        
end