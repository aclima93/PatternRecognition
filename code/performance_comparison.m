% --------------------------- %
% Compare Performance Results %
% --------------------------- %

global SIMULATION_PATH

% TODO: for each simulation
num_simulations = 0;

accuracy = zeros(num_simulations, 1);
recall = zeros(num_simulations, 1);
precision = zeros(num_simulations, 1);
prevalence = zeros(num_simulations, 1);
sensitivity = zeros(num_simulations, 1);
specificity = zeros(num_simulations, 1);
f_measure = zeros(num_simulations, 1);
    
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
    f_measure(i) = stats.f_measure;

end

% Accuracy
figure;
plot(accuracy)

title('Accuracy of Simulations')
ylabel('Accuracy')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'accuracy'); 

% Recall
figure;
plot(recall)

title('Recall of Simulations')
ylabel('Recall')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'recall'); 

% Precision
figure;
plot(precision)

title('Precision of Simulations')
ylabel('Precision')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'precision'); 

% Prevalence
figure;
plot(prevalence)

title('Prevalence of Simulations')
ylabel('Prevalence')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'prevalence'); 

% Sensitivity
figure;
plot(sensitivity)

title('Sensitivity of Simulations')
ylabel('Sensitivity')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'sensitivity');

% Specificity
figure;
plot(specificity)

title('Specificity of Simulations')
ylabel('Specificity')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'specificity'); 

% F-Measure
figure;
plot(f_measure)

title('F-Measure of Simulations')
ylabel('F-Measure')
xlabel('Simulation')

save_png(SIMULATION_PATH, 'f_measure'); 

%EOF