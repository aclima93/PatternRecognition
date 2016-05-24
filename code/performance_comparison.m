% --------------------------- %
% Compare Performance Results %
% --------------------------- %

global REFERENCE_PATH
simulation_folders = subdirectories(REFERENCE_PATH);
num_simulations = length(simulation_folders);

% 30 iterations per simulation
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
        
        cd(iteration_path);
        load('tta_out');
        
        stats = tta_out.cpa_out;
        
        accuracy(i, j) = stats.accuracy;
        recall(i, j) = stats.recall;
        precision(i, j) = stats.precision;
        prevalence(i, j) = stats.prevalence;
        sensitivity(i, j) = stats.sensitivity;
        specificity(i, j) = stats.specificity;
        f_measure(i, j) = stats.f_measure;
        simulation_time(i, j) = stats.simulation_time;
    end
    
end

% calculate the average of every property
avg_accuracy = mean(accuracy, 2);
avg_recall = mean(recall, 2);
avg_precision = mean(precision, 2);
avg_prevalence = mean(prevalence, 2);
avg_sensitivity = mean(sensitivity, 2);
avg_specificity = mean(specificity, 2);
avg_f_measure = mean(f_measure, 2);
avg_simulation_time = mean(simulation_time, 2);

% get back to reference directory, just in case
cd(REFERENCE_PATH);

% Accuracy
[Peak, PeakIdx] = findpeaks(accuracy);
figure;
plot(avg_accuracy)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Accuracy')
ylabel('Accuracy')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'accuracy');

% Recall
[Peak, PeakIdx] = findpeaks(recall);
figure;
plot(avg_recall)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Recall')
ylabel('Recall')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'recall');

% Precision
[Peak, PeakIdx] = findpeaks(precision);
figure;
plot(avg_precision)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Precision')
ylabel('Precision')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'precision');

% Prevalence
[Peak, PeakIdx] = findpeaks(prevalence);
figure;
plot(avg_prevalence)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Prevalence')
ylabel('Prevalence')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'prevalence');

% Sensitivity
[Peak, PeakIdx] = findpeaks(sensitivity);
figure;
plot(avg_sensitivity)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Sensitivity')
ylabel('Sensitivity')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'sensitivity');

% Specificity
[Peak, PeakIdx] = findpeaks(specificity);
figure;
plot(avg_specificity)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Specificity')
ylabel('Specificity')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'specificity');

% F-Measure
[Peak, PeakIdx] = findpeaks(f_measure);
figure;
plot(avg_f_measure)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation F-Measure')
ylabel('F-Measure')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'f_measure');

% Simulation Time
[Peak, PeakIdx] = findpeaks(simulation_time);
figure;
plot(avg_simulation_time)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Average Simulation Time')
ylabel('Time (s)')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'f_measure');

%EOF