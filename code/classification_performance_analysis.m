function [ classification_performance ] = classification_performance_analysis( expected_y, predicted_y )
%CLASSIFICATION_ACCURACY Summary of this function goes here
%   True positive = correctly identified
%   False positive = incorrectly identified
%   True negative = correctly rejected
%   False negative = incorrectly rejected

% --------------------------------------------------------
% Calculate accuracy based on predicted and actual results

confusion_matrix = confusionmat(expected_y, predicted_y);

% coherent payment
false_negatives = confusion_matrix(1,1);
true_negatives = confusion_matrix(1,2);

% default payment
true_positives = confusion_matrix(2,1);
false_positives = confusion_matrix(2,2);

% ------------------- %
% Analysis of results %
% ------------------- %

population = length(predicted_y);

true_condition_positive = true_positives + false_negatives;
true_condition_negative = false_positives + true_negatives;

predicted_condition_positive = true_positives + false_positives;
predicted_condition_negative = false_negatives + true_negatives;

% -----------------------
% True Condition Analysis

% Accuracy of predictions
accuracy = (true_positives + true_negatives) / population;

% True positive rate
TPR = true_positives / (true_condition_positive);

% False negative rate - Type II error
FNR = false_negatives / (true_condition_positive);

% False positive rate - Type I error
FPR = false_positives / (true_condition_negative);

% True negative rate
TNR = true_negatives / (true_condition_negative);

true_condition = [TPR, FNR, FPR, TNR];

% ----------------------------
% Predicted Condition Analysis

% Prevalence
prevalence = true_condition_positive / population;

% Positive prediction value
PPV = true_positives / predicted_condition_positive;

% False discovery rate
FDR = false_positives / predicted_condition_positive;

% False omission rate
FOR = false_negatives / predicted_condition_negative;

% Negative predictive value
NPV = true_negatives / predicted_condition_negative;

predicted_condition = [PPV, FDR, FOR, NPV];

% -----------------------
% Diagnostic Analysis

% Positive likelyhood ratio
PLR = TPR / FPR;

% Negative likelyhood ratio
NLR = FNR / TNR;

% Diagnostic odds ratio
DOR = PLR / NLR;

diagnostic_analysis = [PLR, NLR, DOR];

classification_performance = struct('confusion_matrix', confusion_matrix, 'accuracy', accuracy, 'true_condition', true_condition, 'prevalence', prevalence, 'predicted_condition', predicted_condition, 'diagnostic_analysis', diagnostic_analysis);

end
%EOF