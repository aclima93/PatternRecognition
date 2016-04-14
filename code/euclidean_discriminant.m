function [ predicted_y ] = euclidean_discriminant( X, y, test_X)
%euclidean_discriminant Summary of this function goes here
%   Detailed explanation goes here

k = unique(y);

[num_dim, num_samples] = size(X);
num_classes = length(k);

m = zeros(num_dim, num_classes);
%d = zeros(num_classes, num_samples);
g = zeros(num_classes);

for i = 1:num_classes
    % all samples of same class
    idx = ( y == k(i) );

    % class centroid
    m(:, i) = mean( X(:, idx ), 2 );

    %{
    for j = 1:num_samples
        % distance of samples to class centroids
        d(i, j) = sum( (X(:, j) - m(:, i) ) .^2).^0.5 ;
    end
    %}
   
    %
    % TODO: what did i calculate the distance for?
    %

    % linear discriminate function
    g(i) = dot( m(:, i)' , test_X) + sum( m(:, i)).^2;
    
end

[~, M] = size(test_X);
predicted_y = zeros(1, M);
predicted_y( g >= 0 ) = k(1);
predicted_y( g < 0 ) = k(2);

end
