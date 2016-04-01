function [ mu, s, normalized_X ] = scalestd( X )
%SCALESTD
%   Normalizes data distribution

[num_data, ~] = size(X);

% mean of each feature (column)
mu = mean(X);

% standard deviation of each feature (column)
s = std(X);

% (X - mu) / s --> for each sample --> normalized population data
normalized_X = ( X - repmat(mu, num_data, 1)) ./ repmat(s, num_data, 1);

end
%EOF