
global UI_MODE
global DATASET_PATH
global VISUALIZE_DATA_FLAG
global NORMALIZE_FLAG 
global FEATURE_SELECTION_FLAG 
global FEATURE_REDUCTION_FLAG

global SIMULATION_PATH

configuration_path = concat_flags();

if UI_MODE
    SIMULATION_PATH = sprintf('../images/UI/%s', configuration_path);
else
    SIMULATION_PATH = sprintf('../images/simulations/%s', configuration_path);
end

% delete previously obtained results for same configuration
if exist(SIMULATION_PATH, 'dir')
    rmdir(SIMULATION_PATH, 's')
end
mkdir(SIMULATION_PATH);


    
% ------------------- %
% Data Pre-Processing %
% ------------------- %

% ------------
% Load dataset
original_data = load(DATASET_PATH);
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

save( strcat(SIMULATION_PATH, '/results.mat'), 'tta_out');

% ------------------- %
% Performance Results %
% ------------------- %

%run('performance_results');

%EOF