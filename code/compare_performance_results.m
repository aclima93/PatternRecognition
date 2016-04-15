% --------------------------- %
% Compare Performance Results %
% --------------------------- %

% for each dataset
tta_labels = fieldnames(tta_out);
num_tta_labels = length(tta_labels);

% for each classifier

classifier_labels = fieldnames( tta_out.( tta_labels{1} ));
num_classifier_labels = length(classifier_labels);

% for each set of statistical results
%cpa_label_groups = {'Condition Analysis', 'Accuracy' 'True Condition', 'Prevalence', 'Predicted Condition', 'Diagnostic Analysis'};
%cpa_labels = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives', 'Accuracy', 'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate', 'Prevalence', 'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};

accuracy = zeros(num_tta_labels, num_classifier_labels);
prevalence = zeros(num_tta_labels, num_classifier_labels);
sensitivity = zeros(num_tta_labels, num_classifier_labels);
specificity = zeros(num_tta_labels, num_classifier_labels);

for i = 1:num_tta_labels

    first_stats = tta_out.( tta_labels{i} ).( classifier_labels{1} ).cpa_out;
    
    for j = 1:num_classifier_labels
   
        stats = tta_out.( tta_labels{i} ).( classifier_labels{j} ).cpa_out;
        
        accuracy(i, :) = stats.accuracy;
        prevalence(i, :) = stats.prevalence;
        sensitivity(i, :) = stats.true_condition(1);
        specificity(i, :) = stats.true_condition(4);
        
    end
 
end

% Accuracy
figure;
imagesc(accuracy)
colorbar

title('Accuracy')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Prevalence
figure;
imagesc(prevalence)
colorbar

title('Prevalence')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Sensitivity
figure;
imagesc(sensitivity)
colorbar

title('Sensitivity')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Specificity
figure;
imagesc(specificity)
colorbar

title('Specificity')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

%EOF