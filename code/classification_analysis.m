function [ classification_performance ] = classification_analysis( expected_y, predicted_y )
%CLASSIFICATION_ACCURACY Analysis of classification
%   True positive = correctly identified
%   False positive = incorrectly identified
%   True negative = correctly rejected
%   False negative = incorrectly rejected

global SIMULATION_PATH

N = length(predicted_y);
x = 1:N;
figure;
hold on;
plot(x, expected_y, 'O');
plot(x, predicted_y, '.');
hold off;
axis([-inf, +inf, -1, 2])
legend('Expected', 'Predicted')
save_png(SIMULATION_PATH, 'expected_and_predicted'); 

% --------------------------------------------------------
% Calculate accuracy based on predicted and actual results

[C,CM,IND,PER] = confusion(expected_y, predicted_y);

% ----------------
% confusion matrix
plotconfusion(expected_y, predicted_y);
save_png(SIMULATION_PATH, 'confusion_matrix'); 

% ----------
% ROC Curves
positive_class = 0;
[roc_tpr, roc_fpr] = perfcurve(expected_y, predicted_y, positive_class);
figure;
plot(roc_tpr,roc_fpr)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC Curve')
save_png(SIMULATION_PATH, 'roc'); 

% coherent payment
false_negatives = CM(1,1);
true_negatives = CM(1,2);

% default payment
true_positives = CM(2,1);
false_positives = CM(2,2);

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

% ---------------------
% Statistical Relevance
accuracy = (true_positives + true_negatives) / population;

precision = true_positives / false_positives;

recall = true_positives / true_condition_positive;

prevalence = true_condition_positive / population;

sensitivity = TPR;

specificity = TNR;

f_measure = precision * recall;

classification_performance = struct('confusion_matrix', CM, 'accuracy', accuracy, 'precision', precision, 'recall', recall, 'prevalence', prevalence, 'sensitivity', sensitivity, 'specificity', specificity, 'f_measure', f_measure, 'true_condition', true_condition, 'predicted_condition', predicted_condition, 'diagnostic_analysis', diagnostic_analysis);

end
%EOF