function [ predicted_y ] = mahalanobis_discriminant( X, y, test_X)
%mahalanobis_discriminant Summary of this function goes here
%   Detailed explanation goes here

k = unique(y);

[~, num_samples_test_X] = size(test_X);
num_classes = length(k);

g = zeros(num_classes);

for i = 1:num_classes
    % all samples of same class
    idx = ( y == k(i) );

    % class centroid
    m_k = mean( X(:, idx ), 2 );
    

    % inverse covariance matrix 
    C_inv = inv( cov(m_k') );
    w_k = C_inv * m_k;
    w_k0 = -0.5 * m_k' * C_inv * m_k;

    % linear discriminate function
    for j = 1:num_samples_test_X
        g(i) = dot( w_k , test_X (:, j) ) + w_k0 ;
    end
end

predicted_y = zeros(1, num_samples_test_X);
predicted_y( g(1) >= g(2) ) = k(1);
predicted_y( g(1) < g(2) ) = k(2);

end

