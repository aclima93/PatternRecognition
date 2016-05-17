function [ predicted_y ] = mahalanobis_discriminant( X, y, test_X)
%mahalanobis_discriminant Summary of this function goes here
%   Detailed explanation goes here

k = unique(y);

[~, num_samples_test_X] = size(test_X);
num_classes = length(k);

g = zeros(num_classes, num_samples_test_X);

for i = 1:num_classes
    % all samples of same class
    idx = ( y == k(i) );

    % class centroid
    m_k = mean( X(:, idx ), 2 );
    
    % covariance matrix 
    C = cov(X');
    
    % mahalanobis distance between class centroid and each sample in test_X
    for j = 1:num_samples_test_X
        d = abs(m_k - test_X(:, j));
        g(i, j) = d' * inv(C) * d;
    end
end

% determine which class centroid is closest to each sample (minimum distance)
[~, I] = min(g, [], 1);
predicted_y = k(I);

end
%EOF