function [ mu, s, normalized_X ] = scalestd( num_data, X )
%SCALESTD
%   Normalizes data distribution

    mu = mean(X, 2);
    s = std(X, [], 2);

    normalized_X = ( X - repmat(mu, 1, num_data)) ./ repmat(s, 1, num_data);

end

