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

%EOF