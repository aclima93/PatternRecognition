close all

% get data from datasets
data = load('dataset.mat');
%data = load('small_dataset.mat');

[ X, y, labels, num_data, num_features, norm_X ] = treat_data( data );

plot_data(X, labels);
plot_data(norm_X, labels);

% ----------------------------
% Principal Component Analysis
disp('PCA of raw data');
pricipal_component_analysis(X, labels);

disp('PCA of normalized data');
pricipal_component_analysis(norm_X, labels);

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


