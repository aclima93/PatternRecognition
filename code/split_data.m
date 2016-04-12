function [ classifier_data ] = split_data( X, y )
%SPLIT_DATA Summary of this function goes here
%   Detailed explanation goes here

% random permutation of column indexes
shuffle_idx = randperm(size( X ,2));
y = y(shuffle_idx);
X = X(shuffle_idx);

training_ratio = 0.3;
train_X = X(:, 1:end*training_ratio);
test_X = X(:, end*training_ratio:end);
train_expected_y = y(:, 1:end*training_ratio);
test_expected_y = y(:, end*training_ratio:end);

classifier_data = struct('train_X', train_X, 'test_X', test_X, 'train_expected_y', train_expected_y, 'test_expected_y', test_expected_y);

end

