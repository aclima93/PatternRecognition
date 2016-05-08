
global UI_MODE

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
global MATLAB_DT_FLAG
global SVN_FLAG
global KNN_FLAG

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
[train_X, test_X, train_y, test_y] = split_data(data.X, data.y);

% --------------------------- %
% Classification + Prediction %
% --------------------------- %

% ---------------------------------------
% Matlab's Linear Discriminant Classifier
% http://www.mathworks.com/help/stats/discriminant-analysis.html
if MATLAB_LDC_FLAG == 1
    
    % Train the classifier
    classifier = fitcdiscr(train_X', train_y', 'DiscrimType', 'linear');

    % Test the classifier with remaining data
    [predicted_y, ~, ~] = predict(classifier, test_X');

    predicted_y = predicted_y';
    expected_y = test_y;

% -----------------------------
% Euclidian Linear Discriminant
elseif EDC_FLAG == 1
    
    predicted_y = euclidean_discriminant(train_X, train_y, test_X);
    expected_y = test_y;

% -------------------------------
% Mahalanobis Linear Discriminant
elseif MDC_FLAG == 1
    
    predicted_y = mahalanobis_discriminant(train_X, train_y, test_X);
    expected_y = test_y;

% ---------------------------
% Matlab Binary Decision Tree
elseif MATLAB_DT_FLAG == 1
    
    % train the decision tree
    tree = fitctree(train_X', train_y');

    if UI_MODE
        view(tree,'Mode','Graph');
    end
    
    % test the decision tree    
    predicted_y = predict(tree, test_X');
    expected_y = test_y';

% ----------------------
% Support Vector Machine
elseif SVN_FLAG == 1

    % TODO


% --------------------
% k Nearest Neighbours
elseif KNN_FLAG == 1
    
    % number of neighbours equal to the square root of the number of
    % instances is an empirical rule-of-thumb popularized by the 
    % "Pattern Classification" book by Duda et al.
    k = sqrt( length(train_X) );
    
    classifier = fitcknn(train_X, train_y, 'NumNeighbors', k);
    predicted_y = predict(classifier,test_X);
    expected_y = test_y;

end

% Classification Analysis
cpa_out = classification_analysis(expected_y, predicted_y);
tta_out = struct('expected_y', expected_y, 'predicted_y', predicted_y, 'cpa_out', cpa_out);

save( strcat(SIMULATION_PATH, '/results.mat'), 'tta_out');

%EOF
