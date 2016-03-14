close all

% get data from datasets
%data = load('dataset.mat');
data = load('small_dataset.mat');

[ X, y, labels, num_data, num_features, norm_X ] = treat_data( data );

plot_data(X, labels);
plot_data(norm_X, labels);

% ----------------------------
% Principal Component Analysis
disp('PCA of raw data');
[model, out_data] = pricipal_component_analysis(X, y, labels);
disp('PCA of normalized data');
[model, out_data] = pricipal_component_analysis(norm_X, y, labels);

% ---------------------------------------
% Principal Component Analysis Classifier

% ----------------------------
% Linear Discriminant Analysis

% ---------------------------------------
% Linear Discriminant Analysis Classifier

% -----------------
% Bayesian Analysis

% ----------------------------
% Bayesian Analysis Classifier


