function [ X, y, labels, num_data, num_features, norm_X ] = treat_data( data )
%TREAT_DATA Summary of this function goes here
%   Detailed explanation goes here

disp('Reading data...');
X = data.X;
y = data.y;
labels = data.labels;
[num_data, num_features] = size(X);

% Normalize data
disp('Normalizing data...');
[~, ~, norm_X] = scalestd(X);

end

