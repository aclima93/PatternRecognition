function [  ] = classification_accuracy( true_values, predicted_values, positive_values, negative_values )
%CLASSIFICATION_ACCURACY Summary of this function goes here
%   True positive = correctly identified
%   False positive = incorrectly identified
%   True negative = correctly rejected
%   False negative = incorrectly rejected


% --------------------------------------------------------
% Calculate accuracy based on predicted and actual results

for i = positive_values
    true_positives = length(find( true_values == i & predicted_values == i ));
    false_positives = length(find( true_values == i & predicted_values ~= i ));
end

for i = negative_values
    true_negatives = length(find( true_values == i & predicted_values == i ));
    false_negatives = length(find( true_values == i & predicted_values ~= i ));
end


% ------------------- %
% Analysis of results %
% ------------------- %

% Table ilustrating Classification Accuracy
f = figure;
d = [true_positives, false_positives; false_negatives, true_negatives];
cnames = {'Condition Positive','Condition Negative'};
rnames = {'Predicted Condition Positive','Predicted Condition Negative'};
t = uitable(f,'Data',d,'ColumnName',cnames,'RowName',rnames);
% Set width and height
t.Position(3) = t.Extent(3);
t.Position(4) = t.Extent(4);

population = length(predicted_values);

true_condition_positive = true_positives + false_negatives;
true_condition_negative = false_positives + true_negatives;

predicted_condition_positive = true_positives + false_positives;
predicted_condition_negative = false_negatives + true_negatives;

% -----------------------
% True Condition Analysis

% Accuracy of predictions
ACC = (true_positives + true_negatives) / population;

% True positive rate
TPR = true_positives / (true_condition_positive);

% False negative rate - Type II error
FNR = false_negatives / (true_condition_positive);

% False positive rate - Type I error
FPR = false_positives / (true_condition_negative);

% True negative rate
TNR = true_negatives / (true_condition_negative);

figure;
bar(1:4, [TPR, FNR, FPR, TNR])

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

figure;
bar(1:4, [PPV, FDR, FOR, NPV])

% -----------------------
% Diagnostic Analysis

% Positive likelyhood ratio
PLR = TPR / FPR;

% Negative likelyhood ratio
NLR = FNR / TNR;

% Diagnostic odds ratio
DOR = PLR / NLR;

figure;
bar(1:2, [PLR, NLR])


end
%EOF