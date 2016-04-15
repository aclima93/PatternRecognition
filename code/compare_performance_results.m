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

for i = 1:num_tta_labels

    first_stats = tta_out.( tta_labels{i} ).( classifier_labels{1} ).cpa_out;
    
    condition_analysis = zeros( num_classifier_labels, length(first_stats.condition_analysis) );
    accuracy = zeros( num_classifier_labels, length(first_stats.accuracy) );
    true_condition = zeros( num_classifier_labels, length(first_stats.true_condition) );
    prevalence = zeros( num_classifier_labels, length(first_stats.prevalence) );
    predicted_condition = zeros( num_classifier_labels, length(first_stats.predicted_condition) );
    diagnostic_analysis = zeros( num_classifier_labels, length(first_stats.diagnostic_analysis) );
    
    for j = 1:num_classifier_labels
   
        stats = tta_out.( tta_labels{i} ).( classifier_labels{j} ).cpa_out;
        
        condition_analysis(j,:) = stats.condition_analysis;
        accuracy(j) = stats.accuracy;
        true_condition(j,:) = stats.true_condition;
        prevalence(j) = stats.prevalence;
        predicted_condition(j,:) = stats.predicted_condition;
        diagnostic_analysis(j,:) = stats.diagnostic_analysis;
        
    end
    
    % Chalk up the best accuracy
    [~, best_j] = max(accuracy);
    best_tta_cpa_accuracy(i, best_j) = best_tta_cpa_accuracy(i, best_j) + 1;
    
    %{
    
    % --------------------
    % Colormap Comparisons
    
    % Condition Analysis
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives'};
    xlabel('Condition Analysis')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(condition_analysis)
    
    % True Condition
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate'};
    xlabel('True Condition')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(true_condition)
    
    % Predicted Condition
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Prediction Value', 'False Discovery Rate', 'False Omission Rate', 'Negative Predictive Value'};
    xlabel('Predicted Condition')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(predicted_condition)
    
    % Diagnostic Analysis
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};
    xlabel('Diagnostic Analysis')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(diagnostic_analysis)
    
    % ------------------
    % Linear Comparisons
    
    % Accuracy
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    xlabel('Classifier')
    ylabel('Accuracy')
    plot(accuracy)
    
    % Prevalence
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    xlabel('Classifier')
    ylabel('Prevalence')
    plot(prevalence)
        
    close all;
    %}
    
end

figure;
title('Best Accuracy')
ax = gca;
ax.XTickLabel = tta_labels;
ax.YTickLabel = classifier_labels;
xlabel('Data Model')
ylabel('Classifier')
zlabel('Count')
bar3(best_tta_cpa_accuracy);

%EOF