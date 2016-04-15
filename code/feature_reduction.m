% ----------------- %
% Feature Reduction %
% ----------------- %

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
pca_out = pricipal_component_analysis(redux_data);
close all;

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
lda_out = linear_discriminant_analysis(redux_data);
close all;

% TODO: Skew and Skree (?) tests to choose min number of components and
% only do for that range [min_dim, cur_dim]

%EOF