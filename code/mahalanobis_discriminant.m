function [ predicted_y ] = mahalanobis_discriminant( X, y, test_X)
%mahalanobis_discriminant Summary of this function goes here
%   Detailed explanation goes here

k = unique(y);

[num_dim, ~] = size(X);
[~, num_samples_test_X] = size(test_X);
num_classes = length(k);

m = zeros(num_dim, num_classes);
g = zeros(num_classes);

for i = 1:num_classes
    % all samples of same class
    idx = ( y == k(i) );

    % class centroid
    m(:, i) = mean( X(:, idx ), 2 );
    
end

% inverse covariance matrix 
C_inv = inv( cov(m') );

for i = 1:num_classes    
    % linear discriminate function
    for j = 1:num_samples_test_X
        g(i) = dot( (C_inv * m(:, i)) , test_X (:, j) ) - 0.5*(m(:, i)' * C_inv * m(:, i));
    end
end

predicted_y = zeros(1, num_samples_test_X);
predicted_y( g(1) >= g(2) ) = k(1);
predicted_y( g(1) < g(2) ) = k(2);

end

