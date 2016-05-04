% ----------------- %
% Feature Selection %
% ----------------- %

global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG

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

            cols = find(X_correlation_covariance_out.correlation(n,:) >= X_COR_COV_THRESHOLD_FLAG);
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
    idx_redu_X = find(Xy_correlation_covariance_out.correlation >= XY_COR_COV_THRESHOLD_FLAG);
else
    idx_redu_X = [];
end

% ---------------------------------------------------------------
% Kruskal-Wallis parametric test discard features above a p-score

if KRUSKAL_WALLIS_FLAG
    kruskal_wallis_out = kruskal_wallis(data.X, data.y, data.labels);
    idx_kruskal_wallis = find(kruskal_wallis_out <= KRUSKAL_WALLIS_THRESHOLD_FLAG);
else
    idx_kruskal_wallis = [];
end

% --------------------------
% Merging Feature Selections

% no feature selection (default case)
idx = 1:size(data.X, 1);

if (isempty(idx_redund_X) + isempty(idx_redu_X) + isempty(idx_kruskal_wallis)) == 1
    
    % only one used, just use the union of them all
    idx = union( union(idx_redund_X, idx_redu_X), idx_kruskal_wallis);
    
else
    
    if ~isempty(idx_redund_X) && ~isempty(idx_redu_X) && ~isempty(idx_kruskal_wallis)
        % use all selection methods
        idx = intersect(intersect(idx_redund_X, idx_redu_X), idx_kruskal_wallis);
    
    elseif isempty(idx_redund_X) && ~isempty(idx_redu_X) && ~isempty(idx_kruskal_wallis)
        % Xy_cor and K-W
        idx = intersect(idx_redu_X, idx_kruskal_wallis);
    
    elseif ~isempty(idx_redund_X) && isempty(idx_redu_X) && ~isempty(idx_kruskal_wallis)
        % X_cor and K-W
        idx = intersect(idx_redund_X, idx_kruskal_wallis);
    
    elseif ~isempty(idx_redund_X) && ~isempty(idx_redu_X) && isempty(idx_kruskal_wallis)
        % X_cor and Xy_cor
        idx = intersect(idx_redund_X, idx_redu_X);
    end

end

redux_data = data;
redux_data.X = redux_data.X(idx, :); 
redux_data.labels = redux_data.labels(idx); 
redux_data.dim = length(idx); 

data = redux_data;

%EOF