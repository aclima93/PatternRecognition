function [ norm_data ] = normalize_data( data )
%TREAT_DATA Summary of this function goes here
%   Detailed explanation goes here

% Normalize data
disp('Normalizing data...');
norm_data = data;
[~, ~, norm_X] = scalestd(data.X);
norm_data.X = norm_X;

end
%EOF
