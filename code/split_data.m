function [ classifier_data ] = split_data( X, y )
%SPLIT_DATA Create a stratified training dataset
% 70% of 0 class samples and 70% of 1 class samples for training and 
% vice versa for testing. Random sampling can biase the classifier's
% prediction.

training_ratio = 0.7;
train_X = [];
test_X = [];
train_y = [];
test_y = [];

for class_label = unique(y)

    idx = find( y == class_label);
    train_idx = idx(:, 1:round(end*training_ratio));
    test_idx = idx(:, round(end*training_ratio)+1:end);
    
    if isempty(train_X)
        
        train_X = X(:, train_idx);
        test_X = X(:, test_idx);
        train_y = y(train_idx);
        test_y = y(test_idx);
        
    else
        
        train_X = horzcat( train_X, X(:, train_idx));
        test_X = horzcat( test_X, X(:, test_idx));
        train_y = horzcat( train_y, y(train_idx));
        test_y = horzcat( test_y, y(test_idx));
        
    end
    
end

classifier_data = struct('train_X', train_X, 'test_X', test_X, 'train_y', train_y, 'test_y', test_y);

end

