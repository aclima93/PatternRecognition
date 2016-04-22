close all

NORMALIZE_FLAG = 1;
FEATURE_SELECTION_FLAG = 1;
FEATURE_REDUCTION_FLAG = 1;

if ~exist('images', 'dir')
    rmdir('images', 's')
end
    
% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
original_data = load('data/dataset.mat');
data = original_data;
plot_data(data.X, data.labels, data.dim, data.num_data);

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

% tta: train_test_analysis
tta_out = struct;
reduction_data_labels = fieldnames(reduction_data);

for i = 1:length(reduction_data_labels)
    data = reduction_data.(reduction_data_labels{i});
    tta_out.(reduction_data_labels{i}) = train_test_analysis( data.X, data.y);
end

% --------------------------- %
% Compare Performance Results %
% --------------------------- %

run('compare_performance_results');

%EOF