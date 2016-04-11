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

% find features that represent other features for correlations above 90%
redund_X_threshold = 0.9;
[N, ~] = size(norm_data.X);
representative = zeros(N,1);
represented = zeros(N,1);

for i = 1:N
    if ~represented(i)
        
        cols = find(X_correlation_covariance_out.correlation(i,:) >= redund_X_threshold);
        if ~isempty(cols)
        
            representative(i) = 1;
            represented( cols(cols ~= i) ) = 1;
        end
    end
end

% features that represent other features for correlations above 90%
idx_redund_X = find( representative == 1 );

% ------------------------------------------------------
% Feature Reduction for Correlation with Expected Output

Xy_correlation_covariance_out = Xy_correlation_covariance(norm_data.X, norm_data.y, norm_data.labels);

% correlations above 50%
idx_redu_X = find(Xy_correlation_covariance_out.correlation >= 0.5);

% ------------------------------------------------------
% TODO: perform Kruskal-Wallis test and discard features 
% with p-score above 0.5
%kruskal_wallis_out = kruskal_wallis(norm_data.X, norm_data.y, norm_data.labels);

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