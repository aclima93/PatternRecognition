close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
data = load('data/dataset.mat');

norm_data = normalize_data( data );

%plot_data(data.X, data.labels, data.dim, data.num_data);
%plot_data(norm_data.X, norm_data.labels, norm_data.dim, norm_data.num_data);

% --------------------------- %
% Feature Reduction/Selection %
% --------------------------- %

% --------------------------------
% Feature Reduction for Redundancy

X_correlation_covariance_out = X_correlation_covariance(norm_data.X, norm_data.labels);
redund_data = norm_data;

% correlations above 90%
idx_redund_X = find(X_correlation_covariance_out.correlation > 0.9);

redund_data.X = redund_data.X(idx_redund_X);
redund_data.labels = redund_data.labels(idx_redund_X);
redund_data.dim = length(idx_redund_X);

% ------------------------------------------------------
% Feature Reduction for Correlation with Expected Output

Xy_correlation_covariance_out = Xy_correlation_covariance(norm_data.X, norm_data.y, norm_data.labels);
redu_data = norm_data;

% correlations above 50%
idx_redu_X = find(Xy_correlation_covariance_out.correlation > 0.5);

redu_data.X = redu_data.X(idx_redu_X);
redu_data.labels = redu_data.labels(idx_redu_X);
redu_data.dim = length(idx_redu_X);

% ------------------------------------------------------
% TODO: perform Kruskal-Wallis test and discard features 
% with p-score above 0.5

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
pca_out = pricipal_component_analysis(redund_data);

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
lda_out = linear_discriminant_analysis(redund_data);

% --------------------------- %
% Minimum Distance Classifier %
% --------------------------- %

% TODO

% ------------------
% Euclidian Distance
%d = sum((x-y).^2).^0.5;

% -----------------------------
% Normalized Euclidian Distance (maybe don't do this one because of assumption?)

% --------------------
% Mahalanobis Distance
%d = mahal(Y,X);

% -------------------------- %
% Classification Performance %
% -------------------------- %

classout =  randi(2,1, data.num_data)-1; % TODO: change this to the classification output!
cp_out = classification_performance_analysis(data.y, classout, [1], [0]);

%EOF