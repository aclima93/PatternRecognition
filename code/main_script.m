
global UI_MODE
global DATASET_PATH
global VISUALIZE_DATA_FLAG
global NORMALIZE_FLAG 
global FEATURE_SELECTION_FLAG 
global FEATURE_REDUCTION_FLAG

global REFERENCE_PATH
global SIMULATION_COUNTER
global SIMULATION_PATH

if UI_MODE == 0
    SIMULATION_PATH = sprintf('%s/%d', REFERENCE_PATH, SIMULATION_COUNTER);
else
    SIMULATION_PATH = REFERENCE_PATH;
end

% delete previously obtained results for same configuration
if exist(SIMULATION_PATH, 'dir')
    rmdir(SIMULATION_PATH, 's')
end
mkdir(SIMULATION_PATH);

save_flags();
    
% ------------------- %
% Data Pre-Processing %
% ------------------- %

% ------------
% Load dataset
% (if not already loaded)
if ~exist('original_data', 'var')
    
    original_data = load(DATASET_PATH);
    data = original_data;
    if VISUALIZE_DATA_FLAG
        plot_data(data.X, data.labels, data.dim, data.num_data);
    end
end

% start simulation timer
start_time = tic;

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

disp('Performing training and testing...');
run('train_test_classify');

%EOF