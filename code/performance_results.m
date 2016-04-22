% --------------------------- %
% Compare Performance Results %
% --------------------------- %

% TODO: run 30 times each simulation
iteration = 0;
simulation_path = sprintf('images/simulations/run_%d', iteration);

% for each classifier

classifier_labels = fieldnames( tta_out );
num_classifier_labels = length(classifier_labels);

% for each set of statistical results
%cpa_label_groups = {'Condition Analysis', 'Accuracy' 'True Condition', 'Prevalence', 'Predicted Condition', 'Diagnostic Analysis'};
%cpa_labels = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives', 'Accuracy', 'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate', 'Prevalence', 'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};

accuracy = zeros(num_classifier_labels, 1);
prevalence = zeros(num_classifier_labels, 1);
sensitivity = zeros(num_classifier_labels, 1);
specificity = zeros(num_classifier_labels, 1);
    
for i = 1:num_classifier_labels

    stats = tta_out.(classifier_labels{i}).cpa_out;

    accuracy(i) = stats.accuracy;
    prevalence(i) = stats.prevalence;
    sensitivity(i) = stats.true_condition(1);
    specificity(i) = stats.true_condition(4);

end

% Accuracy
figure('Visible','off')
plot(accuracy)

title('Accuracy')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Data Model')
xlabel('Classifier')

save_png(simulation_path, 'accuracy'); close all;

% Prevalence
figure('Visible','off')
plot(prevalence)

title('Prevalence')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Data Model')
xlabel('Classifier')

save_png(simulation_path, 'prevalence'); close all;

% Sensitivity
figure('Visible','off')
plot(sensitivity)

title('Sensitivity')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Data Model')
xlabel('Classifier')

save_png(simulation_path, 'sensitivity'); close all;

% Specificity
figure('Visible','off')
plot(specificity)

title('Specificity')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Data Model')
xlabel('Classifier')

save_png(simulation_path, 'specificity'); close all;

%EOF