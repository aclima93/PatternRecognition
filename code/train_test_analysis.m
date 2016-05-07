function train_test_analysis( X, y )
%TRAIN_TEST_ANALYSE Summary of this function goes here
%   Detailed explanation goes here

global UI_MODE

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
global MATLAB_DT_FLAG

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
classifier_data = split_data(X, y);
expected_y = [];
predicted_y = [];

% TODO: Matlab functions will without a doubt be better so we will only test them with regard to the final results

% --------------------------------------- %
% Matlab's Linear Discriminant Classifier %
% --------------------------------------- %
% http://www.mathworks.com/help/stats/discriminant-analysis.html

if MATLAB_LDC_FLAG
    % Train the classifier
    classifier = fitcdiscr(classifier_data.train_X', classifier_data.train_y', 'DiscrimType', 'linear');

    % Test the classifier with remaining data
    [predicted_y, ~, ~] = predict(classifier, classifier_data.test_X');

    predicted_y = predicted_y';
    expected_y = classifier_data.test_y;
end

% ---------------------------- %
% Minimum Distance Classifiers %
% ---------------------------- %

% -----------------------------
% Euclidian Linear Discriminant

if EDC_FLAG
    predicted_y = euclidean_discriminant(classifier_data.train_X, classifier_data.train_y, classifier_data.test_X);
    expected_y = classifier_data.test_y;
end

% -----------------------------
% Normalized Euclidian Distance (maybe don't do this one because of assumption?)

% -------------------------------
% Mahalanobis Linear Discriminant

if MDC_FLAG
    predicted_y = mahalanobis_discriminant(classifier_data.train_X, classifier_data.train_y, classifier_data.test_X);
    expected_y = classifier_data.test_y;
end

% --------------------------- %
% Matlab Binary Decision Tree %
% --------------------------- %

if MATLAB_DT_FLAG
    % train the decision tree
    tree = fitctree(classifier_data.train_X', classifier_data.train_y');

    if UI_MODE
        view(tree,'Mode','Graph');
    end
    
    % test the decision tree    
    predicted_y = predict(tree, classifier_data.test_X');
    expected_y = classifier_data.test_y';
end

% Classification Analysis
cpa_out = classification_analysis(expected_y, predicted_y);
tta_out = struct('expected_y', expected_y, 'predicted_y', predicted_y, 'cpa_out', cpa_out);

save( strcat(SIMULATION_PATH, '/results.mat'), 'tta_out');

end

