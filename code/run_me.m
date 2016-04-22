close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
data = load('data/dataset.mat');

% Normalize data
disp('Normalizing data...');
norm_data = normalize_data(data);

%plot_data(data.X, data.labels, data.dim, data.num_data);
%plot_data(norm_data.X, norm_data.labels, norm_data.dim, norm_data.num_data);

% ----------------- %
% Feature Selection %
% ----------------- %

run('feature_selection');

% ----------------- %
% Feature Reduction %
% ----------------- %

run('feature_reduction');

% ----------------------------------------------------------------- %
% Dataset Split + Training and Testing + Classification Performance %
% ----------------------------------------------------------------- %

% tta: train_test_analysis
tta_out = struct;

% Normalized Data
tta_out.('norm_data') = train_test_analysis( norm_data.X, norm_data.y);

% Reduced Data
tta_out.('redux_data') = train_test_analysis( redux_data.X, redux_data.y);

% PCA Data
for i = 1:length(fieldnames(pca_out))
    first_stats = pca_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('pca_data_', num2str(i))) = train_test_analysis( first_stats.data_projection, first_stats.y);
end

% LDA Data
for i = 1:length(fieldnames(lda_out))
    first_stats = lda_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('lda_data_', num2str(i))) = train_test_analysis( first_stats.data_projection, first_stats.y);
end

% --------------------------- %
% Compare Performance Results %
% --------------------------- %

run('compare_performance_results');

%EOF