
global UI_MODE
global SIMULATION_PATH

global VOTER_FLAG
global MATLAB_LDC_FLAG EDC_FLAG MDC_FLAG MATLAB_DT_FLAG SVM_FLAG KNN_FLAG
global C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG
global C2_MATLAB_LDC_FLAG C2_EDC_FLAG C2_MDC_FLAG C2_MATLAB_DT_FLAG C2_SVM_FLAG C2_KNN_FLAG
global C3_MATLAB_LDC_FLAG C3_EDC_FLAG C3_MDC_FLAG C3_MATLAB_DT_FLAG C3_SVM_FLAG C3_KNN_FLAG

% ------------------------------------ %
% Dataset Split + Training and Testing %
% ------------------------------------ %

% Split the data into stratified samples
[train_X, test_X, train_y, expected_y] = split_data(data.X, data.y);

% --------------------------- %
% Classification + Prediction %
% --------------------------- %

if VOTER_FLAG == 1
    classifier_flags = [
        C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG ;
        C2_MATLAB_LDC_FLAG C2_EDC_FLAG C2_MDC_FLAG C2_MATLAB_DT_FLAG C2_SVM_FLAG C2_KNN_FLAG ;
        C3_MATLAB_LDC_FLAG C3_EDC_FLAG C3_MDC_FLAG C3_MATLAB_DT_FLAG C3_SVM_FLAG C3_KNN_FLAG
        ];
else
    classifier_flags = [
        C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG
        ];
end

num_classifiers = size(classifier_flags, 1);
[~, num_test_samples] = size(test_X);
voted_predicted_y = zeros(num_classifiers, num_test_samples);

% ----------------------------------------------------------
% cycle through the used classifiers and: train, test, apply

for i = 1:num_classifiers
    
    MATLAB_LDC_FLAG = classifier_flags(i, 1);
    EDC_FLAG = classifier_flags(i, 2);
    MDC_FLAG = classifier_flags(i, 3);
    MATLAB_DT_FLAG = classifier_flags(i, 4);
    SVM_FLAG = classifier_flags(i, 5);
    KNN_FLAG = classifier_flags(i, 6);
    
    % ---------------------------------------
    % Matlab's Linear Discriminant Classifier
    % http://www.mathworks.com/help/stats/discriminant-analysis.html
    if MATLAB_LDC_FLAG == 1
        
        % Train the classifier
        classifier = fitcdiscr(train_X', train_y', 'DiscrimType', 'linear');
        
        % Test the classifier with remaining data
        predicted_y = predict(classifier, test_X');
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
    elseif SVM_FLAG == 1
        
        classifier = fitcsvm(train_X', train_y');
        predicted_y = predict(classifier, test_X');
        predicted_y = predicted_y';
        
    % --------------------
    % k Nearest Neighbours
    % http://www.mathworks.com/help/stats/classification-using-nearest-neighbors.html#btap7nm
    elseif KNN_FLAG == 1
        
        % number of neighbours equal to the square root of the number of
        % instances is an empirical rule-of-thumb popularized by the
        % "Pattern Classification" book by Duda et al.
        k = round( sqrt( length(train_X) ) );
        
        classifier = fitcknn(train_X', train_y', 'NumNeighbors', k);
        predicted_y = predict(classifier, test_X');
        predicted_y = predicted_y';

    else
        error('Error. \nNo classifier chosen.');        
    end
    
    voted_predicted_y(i, :) = predicted_y;
    
end

% -------------------------------------
% determine the rounded median of votes
predicted_y = round( median( voted_predicted_y, 1) );

% -----------------------
% Classification Analysis

cpa_out = classification_analysis(expected_y, predicted_y);

simulation_time = toc(start_time); % end simulation timer

tta_out = struct('expected_y', expected_y, 'predicted_y', predicted_y, 'cpa_out', cpa_out, 'simulation_time', simulation_time);

save( strcat(SIMULATION_PATH, '/results.mat'), 'tta_out');

%EOF
