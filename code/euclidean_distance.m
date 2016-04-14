function [ d ] = euclidean_distance( X, y )
%EUCLIDIAN_DISTANCE Summary of this function goes here
%   Detailed explanation goes here

k = unique(y);

[num_dim, num_samples] = size(X);
num_classes = length(k);

m = zeros(num_dim, num_classes);
d = zeros(num_classes, num_samples);

for i = 1:num_classes
    % all samples of same class
    idx = find( y == k(i) );

    % class centroid
    m(:, i) = mean( X(:, idx ), 2 );

    for j = 1:num_samples
        % distance of samples to class centroids
        d(i, j) = sum( (X(:, j) - m(:, i) ) .^2).^0.5 ;
    end
end

end

