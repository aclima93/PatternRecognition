function [ norm_data ] = normalize_data( data )
% Normalize data
%   Normalizes data distribution

norm_data = data;
X = data.X;
normalized_X = zeros(data.dim, data.num_data);

for i=1:data.dim

    % mean of each dimension (line)
    mu = mean(X(i, :));

    % standard deviation of each feature (column)
    s = std(X(i, :));

    % (X - mu) / s
    normalized_X(i, :) = ( X(i, :) - mu) / s;
    
end

norm_data.X = normalized_X;

end
%EOF
