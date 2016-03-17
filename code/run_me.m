close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
%data = load('dataset.mat');
%data = load('medium_dataset.mat');
data = load('small_dataset.mat');

norm_data = normalize_data( data );

plot_data(data.X, data.labels);
plot_data(norm_data.X, norm_data.labels);

% ----------------- %
% Feature Reduction %
% ----------------- %

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
%pricipal_component_analysis(norm_data);

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
%linear_discriminant_analysis(data);

% ----------------- %
% Feature Selection %
% ----------------- %



% --------------------------- %
% Minimum Distance Classifier %
% --------------------------- %

% ------------------
% Euclidian Distance
%d = sum((x-y).^2).^0.5;

% -----------------------------
% Normalized Euclidian Distance (maybe don't do this one)

% --------------------
% Mahalanobis Distance
%d = mahal(Y,X);

% -------------------------- %
% Classification Performance %
% -------------------------- %

classout =  randi(2,1, data.num_data)-1; % TODO: change this to the classification output!
classification_accuracy(data.y, classout, [1], [2]);

%EOF