function [ tta_out ] = train_test_analysis( X, y )
%TRAIN_TEST_ANALYSE Summary of this function goes here
%   Detailed explanation goes here

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG

tta_out = struct;
positive_values = [1];
negative_values = [0];

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
classifier_data = split_data(X, y);

% TODO: Matlab functions will without a doubt be better so we will only test them with regard to the final results

% --------------------------------------- %
% Matlab's Linear Discriminant Classifier %
% --------------------------------------- %
% http://www.mathworks.com/help/stats/discriminant-analysis.html

if MATLAB_LDC_FLAG
    % Train the classifier
    classifier = fitcdiscr(classifier_data.train_X', classifier_data.train_y', 'DiscrimType', 'linear');

    % Test the classifier with remaining data
    [predicted_y, score, cost] = predict(classifier, classifier_data.test_X');

    % Classification Performance
    cpa_out = classification_performance_analysis(classifier_data.test_y, predicted_y', positive_values, negative_values);

    tta_out.('mldc') = struct('expected_y', classifier_data.test_y, 'predicted_y', predicted_y', 'cpa_out', cpa_out);
end

%{

% TODO: not working for some reason

% ------------------------------------------ %
% Matlab's Quadratic Discriminant Classifier %
% ------------------------------------------ %

% http://www.mathworks.com/help/stats/discriminant-analysis.html

% Train the classifier
classifier = fitcdiscr(classifier_data.train_X', classifier_data.train_y', 'DiscrimType','quadratic');

% Test the classifier with remaining data
[predicted_y, score, cost] = predict(classifier, classifier_data.test_X');

% Classification Performance
cpa_out = classification_performance_analysis(classifier_data.test_y, predicted_y, positive_values, negative_values);

tta_out.('mqdc') = struct('expected_y', classifier_data.test_y, 'predicted_y', predicted_y', 'cpa_out', cpa_out);
%}

% ---------------------------- %
% Minimum Distance Classifiers %
% ---------------------------- %

% -----------------------------
% Euclidian Linear Discriminant

if EDC_FLAG
    predicted_y = euclidean_discriminant(classifier_data.train_X, classifier_data.train_y, classifier_data.test_X);

    % Classification Performance
    cpa_out = classification_performance_analysis(classifier_data.test_y, predicted_y, positive_values, negative_values);

    tta_out.('edc') = struct('expected_y', classifier_data.test_y, 'predicted_y', predicted_y, 'cpa_out', cpa_out);
end

% -----------------------------
% Normalized Euclidian Distance (maybe don't do this one because of assumption?)

% -------------------------------
% Mahalanobis Linear Discriminant

if MDC_FLAG
    predicted_y = mahalanobis_discriminant(classifier_data.train_X, classifier_data.train_y, classifier_data.test_X);

    % Classification Performance
    cpa_out = classification_performance_analysis(classifier_data.test_y, predicted_y, positive_values, negative_values);

    tta_out.('mdc') = struct('expected_y', classifier_data.test_y, 'predicted_y', predicted_y, 'cpa_out', cpa_out);
end

% TODO

% ------------------
% Average Error Rate

% ---------
% F-measure

% ----------
% ROC Curves

end

