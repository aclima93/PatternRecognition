function [ tta_out ] = train_test_analysis( X, y )
%TRAIN_TEST_ANALYSE Summary of this function goes here
%   Detailed explanation goes here

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
classifier_data = split_data(X, y);

% Train the classifier
classifier = fitcdiscr(classifier_data.train_X', classifier_data.train_y');

% Test the classifier with remaining data
[predicted_y, score, cost] = predict(classifier, classifier_data.test_X');

% --------------------------- %
% Minimum Distance Classifier %
% --------------------------- %

% TODO

% ------------------
% Euclidian Distance
%d = sum((x-y).^2).^0.5;

% -----------------------------
% Normalized Euclidian Distance (maybe don't do this one because of assumption?)

% --------------------
% Mahalanobis Distance
%d = mahal(Y,X);

% -------------------------- %
% Classification Performance %
% -------------------------- %

positive_values = [1];
negative_values = [0];
% cpa: classification_performance_analysis
cpa_out = classification_performance_analysis(classifier_data.test_y', predicted_y, positive_values, negative_values);

% ------------------
% Average Error Rate

% ---------
% F-measure

% ----------
% ROC Curves

tta_out = struct('expected_y', classifier_data.test_y, 'predicted_y', predicted_y', 'cpa_out', cpa_out);

end

