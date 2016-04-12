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
% Feature Reduction with all suggestions

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

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
pca_out = pricipal_component_analysis(redux_data);

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
lda_out = linear_discriminant_analysis(redux_data);

% -------------------------------
% Training and Test Dataset Split
% -------------------------------

% random permutation of column indexes
shuffle_idx = randperm(size( redux_data.X ,2));
y = redux_data.y(suffle_idx);
X = redux_data.X(suffle_idx);

training_ratio = 0.3;
train_X = X(:, 1:end*training_ratio);
test_X = X(:, end*training_ratio:end);
train_expected_y = y(:, 1:end*training_ratio);
test_expected_y = y(:, end*training_ratio:end);

classifier_data = struct('train_X', train_X, 'test_X', test_X, 'train_expected_y', train_expected_y, 'test_expected_y', test_expected_y);

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

% ------------------
% Average Error Rate

% ---------
% F-measure

% ----------
% ROC Curves



%EOF