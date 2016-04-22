% ----------------- %
% Feature Selection %
% ----------------- %

% GUI variables
X_COR_COV_FLAG = 1;
redund_X_threshold = 0.9;

XY_COR_COV_FLAG = 1;
redu_X_threshold = 0.5;

KRUSKAL_WALLIS_FLAG = 1;
kw_threshold = 0.05;

% --------------------------------
% Feature Selection for Redundancy

if X_COR_COV_FLAG
    X_correlation_covariance_out = X_correlation_covariance(data.X, data.labels);

    % find features that represent other features for correlations above 90%
    [N, ~] = size(data.X);
    representative = zeros(N,1);
    represented = zeros(N,1);

    for n = 1:N
        if ~represented(n)

            cols = find(X_correlation_covariance_out.correlation(n,:) >= redund_X_threshold);
            if ~isempty(cols)

                representative(n) = 1;
                represented( cols(cols ~= n) ) = 1;
            end
        end
    end
    idx_redund_X = find( representative == 1 );
else
    idx_redund_X = [];    
end

% ------------------------------------------------------
% Feature Selection for Correlation with Expected Output

if XY_COR_COV_FLAG
    Xy_correlation_covariance_out = Xy_correlation_covariance(data.X, data.y, data.labels);
    idx_redu_X = find(Xy_correlation_covariance_out.correlation >= redu_X_threshold);
else
    idx_redu_X = [];
end

% ---------------------------------------------------------------
% Kruskal-Wallis parametric test discard features above a p-score

if KRUSKAL_WALLIS_FLAG
    kruskal_wallis_out = kruskal_wallis(data.X, data.y, data.labels);
    idx_kruskal_wallis = find(kruskal_wallis_out <= kw_threshold);
else
    idx_kruskal_wallis = [];
end

% --------------------------
% Merging Feature Selections

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
redux_data = data;
redux_data.X = redux_data.X(idx, :); 
redux_data.labels = redux_data.labels(idx); 
redux_data.dim = length(idx); 

data = redux_data;

%EOF