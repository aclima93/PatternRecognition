
global UI_MODE
global SIMULATION_PATH

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
global MATLAB_DT_FLAG
global SVN_FLAG
global KNN_FLAG

global VALIDATION_FLAG
global VALIDATION_DATASET_PATH

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
[train_X, test_X, train_y, expected_y] = split_data(data.X, data.y);

% ------------------------------------------ %
% Classification + Prediction (+ Validation) %
% ------------------------------------------ %

% ---------------------------------------
% Matlab's Linear Discriminant Classifier
% http://www.mathworks.com/help/stats/discriminant-analysis.html
if MATLAB_LDC_FLAG == 1
    
    % Train the classifier
    classifier = fitcdiscr(train_X', train_y', 'DiscrimType', 'linear');
    
    % Test the classifier with remaining data
    [predicted_y, ~, ~] = predict(classifier, test_X');
    predicted_y = predicted_y';
    
    % -----------------------------
    % Euclidian Linear Discriminant
elseif EDC_FLAG == 1
    
    predicted_y = euclidean_discriminant(train_X, train_y, test_X);
    
    % -------------------------------
    % Mahalanobis Linear Discriminant
elseif MDC_FLAG == 1
    
    predicted_y = mahalanobis_discriminant(train_X, train_y, test_X);
    
    % ---------------------------
    % Matlab Binary Decision Tree
elseif MATLAB_DT_FLAG == 1
    
    % train the decision tree
    classifier = fitctree(train_X', train_y');
    
    if UI_MODE
        view(classifier,'Mode','Graph');
    end
    
    % test the decision tree
    predicted_y = predict(classifier, test_X');
    predicted_y = predicted_y';
    
    % ----------------------
    % Support Vector Machine
elseif SVN_FLAG == 1
    
    classifier = fitcsvm(train_X, train_y);
    predicted_y = predict(classifier, test_X);
    
    
    % --------------------
    % k Nearest Neighbours
    % http://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html#btap7nm
elseif KNN_FLAG == 1
    
    % number of neighbours equal to the square root of the number of
    % instances is an empirical rule-of-thumb popularized by the
    % "Pattern Classification" book by Duda et al.
    k = sqrt( length(train_X) );
    
    classifier = fitcknn(train_X, train_y, 'NumNeighbors', k);
    predicted_y = predict(classifier, test_X);
    
end

if VALIDATION_FLAG == 1
    validation_data = load(VALIDATION_DATASET_PATH);
    
    if EDC_FLAG == 1
        
        predicted_validation_y = euclidean_discriminant(train_X, train_y, validation_data.X);
        
    elseif MDC_FLAG == 1
        
        predicted_validation_y = mahalanobis_discriminant(train_X, train_y, validation_data.X);
        
    else
        predicted_validation_y = predict(classifier, validation_data.X);
    end
    
end

% -----------------------
% Classification Analysis

cpa_out = classification_analysis(expected_y, predicted_y);

simulation_time = toc(start_time); % end simulation timer

tta_out = struct('expected_y', expected_y, 'predicted_y', predicted_y, 'predicted_validation_y', predicted_validation_y, 'cpa_out', cpa_out, 'simulation_time', simulation_time);

save( strcat(SIMULATION_PATH, '/results.mat'), 'tta_out');

%EOF
