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

best_tta_cpa_accuracy = zeros(num_tta_labels, num_classifier_labels);
best_tta_cpa_prevalence = zeros(num_tta_labels, num_classifier_labels);
best_tta_cpa_sensitivity = zeros(num_tta_labels, num_classifier_labels);
best_tta_cpa_specificity = zeros(num_tta_labels, num_classifier_labels);

for i = 1:num_tta_labels

    first_stats = tta_out.( tta_labels{i} ).( classifier_labels{1} ).cpa_out;
    
    accuracy = zeros( num_classifier_labels, 1);
    prevalence = zeros( num_classifier_labels, 1);
    sensitivity = zeros( num_classifier_labels, 1);
    specificity = zeros( num_classifier_labels, 1);
    
    for j = 1:num_classifier_labels
   
        stats = tta_out.( tta_labels{i} ).( classifier_labels{j} ).cpa_out;
        
        accuracy(j) = stats.accuracy;
        prevalence(j) = stats.prevalence;
        sensitivity(j) = stats.true_condition(1);
        specificity(j) = stats.true_condition(4);
        
    end
    
    % Chalk up the better classifier for each model
    [~, best_j] = max(accuracy);
    best_tta_cpa_accuracy(i, best_j) = 1;
    
    [~, best_j] = max(prevalence);
    best_tta_cpa_prevalence(i, best_j) = 1;
    
    [~, best_j] = max(sensitivity);
    best_tta_cpa_sensitivity(i, best_j) = 1;

    [~, best_j] = max(specificity);
    best_tta_cpa_specificity(i, best_j) = 1;
    
    %{
    
    % --------------------
    % Colormap Comparisons
    
    % Condition Analysis
    figure;
    imagesc(condition_analysis)
    colorbar
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives'};
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Condition Analysis')
    ax.YTickLabel = classifier_labels;
    ax.YTick = 1:length(ax.YTickLabel);
    ylabel('Classifier')
    
    % True Condition
    figure;
    imagesc(true_condition)
    colorbar
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate'};
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('True Condition')
    ax.YTickLabel = classifier_labels;
    ax.YTick = 1:length(ax.YTickLabel);
    ylabel('Classifier')
    
    % Predicted Condition
    figure;
    imagesc(predicted_condition)
    colorbar
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Prediction Value', 'False Discovery Rate', 'False Omission Rate', 'Negative Predictive Value'};
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Predicted Condition')
    ax.YTickLabel = classifier_labels;
    ax.YTick = 1:length(ax.YTickLabel);    
    ylabel('Classifier')
    
    % Diagnostic Analysis
    figure;
    imagesc(diagnostic_analysis)
    colorbar
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Diagnostic Analysis')
    ax.YTickLabel = classifier_labels;
    ax.YTick = 1:length(ax.YTickLabel);
    ylabel('Classifier')
    
    % ------------------
    % Linear Comparisons
    
    % Accuracy
    figure;
    plot(accuracy)
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Classifier')
    ylabel('Accuracy')
    
    % Prevalence
    figure;
    plot(prevalence)
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Classifier')
    ylabel('Prevalence')
    
    % Sensitivity
    figure;
    plot(sensitivity)
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Classifier')
    ylabel('Sensitivity')
    
    % Specificity
    figure;
    plot(specificity)
    
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    ax.XTick = 1:length(ax.XTickLabel);
    xlabel('Classifier')
    ylabel('Specificity')
        
    close all;
    %}
    
end

% Better Accuracy
figure;
imagesc(best_tta_cpa_accuracy)
colorbar

title('Better Accuracy')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Better Prevalence
figure;
imagesc(best_tta_cpa_prevalence)
colorbar

title('Better Prevalence')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Better Sensitivity
figure;
imagesc(best_tta_cpa_sensitivity)
colorbar

title('Better Sensitivity')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

% Better Specificity
figure;
imagesc(best_tta_cpa_specificity)
colorbar

title('Better Specificity')
ax = gca;
ax.YTickLabel = tta_labels;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.YTick = 1:length(ax.YTickLabel);
ylabel('Data Model')
xlabel('Classifier')

%EOF