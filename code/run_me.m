close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
data = load('data/dataset.mat');

norm_data = normalize_data( data );

%plot_data(data.X, data.labels, data.dim, data.num_data);
%plot_data(norm_data.X, norm_data.labels, norm_data.dim, norm_data.num_data);

% ----------------- %
% Feature Selection %
% ----------------- %

% --------------------------------
% Feature Selection for Redundancy

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
% Feature Selection for Correlation with Expected Output

Xy_correlation_covariance_out = Xy_correlation_covariance(norm_data.X, norm_data.y, norm_data.labels);

% correlations above 50%
redu_X_threshold = 0.5;
idx_redu_X = find(Xy_correlation_covariance_out.correlation >= redu_X_threshold);

% -----
% TODO: Kruskal-Wallis results are shitty, at best...
% -----

% ----------------------------------------------------------------------
% Kruskal-Wallis parametric test discard features with p-score above 0.5
kruskal_wallis_out = kruskal_wallis(norm_data.X, norm_data.y, norm_data.labels);
kw_threshold = 0.05;
idx_kruskal_wallis = find(kruskal_wallis_out <= kw_threshold);

% --------------------------------------
% Feature Selection with all suggestions

if ~isempty(idx_redund_X) && ~isempty(idx_redu_X)
    idx = intersect(idx_redund_X, idx_redu_X);
elseif isempty(idx_redu_X)
    idx = idx_redund_X;
elseif isempty(idx_redund_X)
    idx = idx_redu_X;
else
    idx = idx_kruskal_wallis;
end
idx = intersect( idx, idx_kruskal_wallis);
redux_data = norm_data;
redux_data.X = redux_data.X(idx, :); 
redux_data.labels = redux_data.labels(idx); 
redux_data.dim = length(idx); 

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
    temp = pca_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('pca_data_', num2str(i))) = train_test_analysis( temp.data_projection, temp.y);
end

% LDA Data
for i = 1:length(fieldnames(lda_out))
    temp = lda_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('lda_data_', num2str(i))) = train_test_analysis( temp.data_projection, temp.y);
end

% --------------------------- %
% Compare Performance Results %
% --------------------------- %

tta_labels = fieldnames(tta_out);
cpa_labels = fieldnames( tta_out.( tta_labels{1} ).('cpa_out') );
comparison_table = zeros(length(tta_labels), length(cpa_labels));

for i = 1:length(tta_labels)
    for j = 1:length(cpa_labels)
   
        comparison_table(i, j) = tta_out.( tta_labels{i} ).('cpa_out').( cpa_labels{j} );

    end
end

% TODO: normalize each comparison_table column and display with imagesc

%EOF