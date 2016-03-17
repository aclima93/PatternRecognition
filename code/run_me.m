close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
%data = load('data/dataset.mat');
%data = load('data/medium_dataset.mat');
data = load('data/small_dataset.mat');

norm_data = normalize_data( data );

plot_data(data.X, data.labels);
plot_data(norm_data.X, norm_data.labels);

% ----------------- %
% Feature Reduction %
% ----------------- %

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
pca_out = pricipal_component_analysis(norm_data);

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
lda_out = linear_discriminant_analysis(norm_data);

% ----------------- %
% Feature Selection %
% ----------------- %

% TODO

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