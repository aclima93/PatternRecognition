close all;
clear;
clc;

global UI_MODE
global VISUALIZE_DATA_FLAG
global NORMALIZE_FLAG 
global FEATURE_SELECTION_FLAG 
global FEATURE_REDUCTION_FLAG

if ~exist('../images', 'dir')
    rmdir('../images', 's')
end
    
% ------------------- %
% Data Pre-Processing %
% ------------------- %

% ------------
% Load dataset
original_data = load('../data/dataset.mat');
data = original_data;
if VISUALIZE_DATA_FLAG
    plot_data(data.X, data.labels, data.dim, data.num_data);
end

% --------------
% Normalize data
if NORMALIZE_FLAG
    disp('Normalizing data...');
    norm_data = normalize_data(data);
    data = norm_data;
end

% ----------------- %
% Feature Selection %
% ----------------- %

if FEATURE_SELECTION_FLAG
    disp('Performing feature selection...');
    run('feature_selection');
end

% ----------------- %
% Feature Reduction %
% ----------------- %

if FEATURE_REDUCTION_FLAG
    disp('Performing feature reduction...');
    run('feature_reduction');
end

% ----------------------------------------------------------------- %
% Dataset Split + Training and Testing + Classification Performance %
% ----------------------------------------------------------------- %

tta_out = train_test_analysis( data.X, data.y);

% ------------------- %
% Performance Results %
% ------------------- %

% TODO: run 30 times each simulation
global SIMULATION_PATH

if UI_MODE
    configuration_path = 'concat_all_flags';
    SIMULATION_PATH = sprintf('../images/UI/%s', configuration_path);
    run('performance_results');
else
    for iteration = 1:30
        configuration_path = 'concat_all_flags';
        SIMULATION_PATH = sprintf('../images/simulations/%s/run_%d', configuration_path ,iteration);
        run('performance_results');
    end
end


%EOF