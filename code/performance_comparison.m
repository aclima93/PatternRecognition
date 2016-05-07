% --------------------------- %
% Compare Performance Results %
% --------------------------- %

% TODO compare all the simulations, don't just plot for each one
% individually. Do somethign smart!!!

global SIMULATION_PATH

% for each simulation

num_simulations = length(classifier_labels);

% for each set of statistical results
%cpa_label_groups = {'Condition Analysis', 'Accuracy' 'True Condition', 'Prevalence', 'Predicted Condition', 'Diagnostic Analysis'};
%cpa_labels = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives', 'Accuracy', 'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate', 'Prevalence', 'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};

accuracy = zeros(num_simulations, 1);
recall = zeros(num_simulations, 1);
precision = zeros(num_simulations, 1);
prevalence = zeros(num_simulations, 1);
sensitivity = zeros(num_simulations, 1);
specificity = zeros(num_simulations, 1);
    
for i = 1:num_simulations

    % TODO:
    % go to folder
    
    stats = tta_out.cpa_out;

    accuracy(i) = stats.accuracy;
    recall(i) = stats.recall;
    precision(i) = stats.precision;
    prevalence(i) = stats.prevalence;
    sensitivity(i) = stats.sensitivity;
    specificity(i) = stats.specificity;

end

% Accuracy
figure;
plot(accuracy)

title('Accuracy of Classifier')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Accuracy')
xlabel('Classifier')

save_png(SIMULATION_PATH, 'accuracy'); 

% Prevalence
figure;
plot(prevalence)

title('Prevalence of Classifier')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Prevalence')
xlabel('Classifier')

save_png(SIMULATION_PATH, 'prevalence'); 

% Sensitivity
figure;
plot(sensitivity)

title('Sensitivity of Classifier')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Sensitivity')
xlabel('Classifier')

save_png(SIMULATION_PATH, 'sensitivity'); 

% Specificity
figure;
plot(specificity)

title('Specificity of Classifier')
ax = gca;
ax.XTickLabel = classifier_labels;
ax.XTick = 1:length(ax.XTickLabel);
ylabel('Specificity')
xlabel('Classifier')

save_png(SIMULATION_PATH, 'specificity'); 

%EOF