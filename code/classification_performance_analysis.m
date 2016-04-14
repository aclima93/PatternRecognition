function [ classification_performance ] = classification_performance_analysis( expected_y, predicted_y, positive_values, negative_values )
%CLASSIFICATION_ACCURACY Summary of this function goes here
%   True positive = correctly identified
%   False positive = incorrectly identified
%   True negative = correctly rejected
%   False negative = incorrectly rejected

% --------------------------------------------------------
% Calculate accuracy based on predicted and actual results

for i = positive_values
    true_positives = length(find( expected_y == i & predicted_y == i ));
    false_positives = length(find( expected_y ~= i & predicted_y == i ));
end

for i = negative_values
    true_negatives = length(find( expected_y == i & predicted_y == i ));
    false_negatives = length(find( expected_y ~= i & predicted_y == i ));
end


% ------------------- %
% Analysis of results %
% ------------------- %

% Table ilustrating Classification Accuracy
%d = [true_positives, false_positives; false_negatives, true_negatives];
%cnames = {'Condition Positive','Condition Negative'};
%rnames = {'Predicted Condition Positive','Predicted Condition Negative'};
%custom_table(d, cnames, rnames);

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

%custom_pie_chart([TPR, FNR, FPR, TNR], {'TPR: ', 'FNR: ', 'FPR: ', 'TNR: '});

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

%custom_pie_chart([PPV, FDR, FOR, NPV], {'PPV: ', 'FDR: ', 'FOR: ', 'NPV: '});

% -----------------------
% Diagnostic Analysis

% Positive likelyhood ratio
PLR = TPR / FPR;

% Negative likelyhood ratio
NLR = FNR / TNR;

% Diagnostic odds ratio
DOR = PLR / NLR;

classification_performance = struct('true_positives', true_positives, 'false_positives', false_positives, 'false_negatives', false_negatives, 'true_negatives', true_negatives, 'accuracy', accuracy, 'TPR', TPR, 'FNR', FNR, 'FPR', FPR, 'TNR', TNR, 'prevalence', prevalence, 'PPV', PPV, 'FDR', FDR, 'FOR', FOR, 'NPV', NPV, 'PLR', PLR, 'NLR', NLR, 'DOR', DOR);

end
%EOF