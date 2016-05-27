% --------------------------- %
% Compare Performance Results %
% --------------------------- %

global REFERENCE_PATH
simulation_folders = subdirectories(REFERENCE_PATH);
num_simulations = length(simulation_folders);

% N iterations per simulation
accuracy = zeros(num_simulations, 1);
recall = zeros(num_simulations, 1);
precision = zeros(num_simulations, 1);
prevalence = zeros(num_simulations, 1);
sensitivity = zeros(num_simulations, 1);
specificity = zeros(num_simulations, 1);
f_measure = zeros(num_simulations, 1);
simulation_time = zeros(num_simulations, 1);

for i = 1:num_simulations
    
    % go to simulation folder
    simulation_path = sprintf('%s/%s', REFERENCE_PATH, simulation_folders(i).name);
    
    iteration_folders = subdirectories(simulation_path);
    num_iterations = length(iteration_folders);
    
    for j = 1:num_iterations
        
        % go to iteration folder
        iteration_path = sprintf('%s/%s', simulation_path, iteration_folders(i).name);
        
        load( sprintf('%s/results', iteration_path) );
        
        stats = tta_out.cpa_out;
        
        accuracy(i, j) = stats.accuracy;
        recall(i, j) = stats.recall;
        precision(i, j) = stats.precision;
        prevalence(i, j) = stats.prevalence;
        sensitivity(i, j) = stats.sensitivity;
        specificity(i, j) = stats.specificity;
        f_measure(i, j) = stats.f_measure;
        simulation_time(i, j) = tta_out.simulation_time;
    end
    
end

% calculate the average of every property and save it in a struct
avg_data = struct;

avg_accuracy = mean(accuracy, 2); avg_data.avg_accuracy = avg_accuracy;
avg_recall = mean(recall, 2); avg_data.avg_recall = avg_recall;
avg_precision = mean(precision, 2); avg_data.avg_precision = avg_precision;
avg_prevalence = mean(prevalence, 2); avg_data.avg_prevalence = avg_prevalence;
avg_sensitivity = mean(sensitivity, 2); avg_data.avg_sensitivity = avg_sensitivity;
avg_specificity = mean(specificity, 2); avg_data.avg_specificity = avg_specificity;
avg_f_measure = mean(f_measure, 2); avg_data.avg_f_measure = avg_f_measure;
avg_simulation_time = mean(simulation_time, 2); avg_data.avg_simulation_time = avg_simulation_time;

% save these averages for post-analysis
save( sprintf('%s/avg_data.mat', REFERENCE_PATH), 'avg_data');

% Accuracy
plot_data_and_peaks( avg_accuracy, 'Average Simulation Accuracy', 'Simulation', 'Accuracy', REFERENCE_PATH, 'accuracy');

% Recall
plot_data_and_peaks( avg_recall, 'Average Simulation Recall', 'Simulation', 'Recall', REFERENCE_PATH, 'recall');

% Precision
plot_data_and_peaks( avg_precision, 'Average Simulation Precision', 'Simulation', 'Precision', REFERENCE_PATH, 'precision');

% Prevalence
plot_data_and_peaks( avg_prevalence, 'Average Simulation Prevalence', 'Simulation', 'Prevalence', REFERENCE_PATH, 'prevalence');

% Sensitivity
plot_data_and_peaks( avg_sensitivity, 'Average Simulation Sensitivity', 'Simulation', 'Sensitivity', REFERENCE_PATH, 'sensitivity');

% Specificity
plot_data_and_peaks( avg_specificity, 'Average Simulation Specificity', 'Simulation', 'Specificity', REFERENCE_PATH, 'specificity');

% F-Measure
plot_data_and_peaks( avg_f_measure, 'Average Simulation F-Measure', 'Simulation', 'F-Measure', REFERENCE_PATH, 'f_measure');

% Simulation Time
plot_data_and_peaks( avg_simulation_time, 'Average Simulation Time', 'Simulation', 'Time (s)', REFERENCE_PATH, 'simulation_time');

disp('Finished performance comparison.');

%EOF