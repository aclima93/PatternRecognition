% --------------------------- %
% Compare Performance Results %
% --------------------------- %

global REFERENCE_PATH

% Get a list of all files and folders in this folder.
% Get a logical vector that tells which is a directory.
% Extract only those that are directories & delete the current (.) and
% parent (..) references.

files = dir(REFERENCE_PATH);
dir_flags = [files.isdir];
simulation_folders = files(dir_flags);
simulation_folders(1:2) = [];

num_simulations = length(simulation_folders);

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
    
    cd(sprintf('%s/%s', REFERENCE_PATH, simulation_folders(i).name));
    load('tta_out');
    
    stats = tta_out.cpa_out;

    accuracy(i) = stats.accuracy;
    recall(i) = stats.recall;
    precision(i) = stats.precision;
    prevalence(i) = stats.prevalence;
    sensitivity(i) = stats.sensitivity;
    specificity(i) = stats.specificity;
    f_measure(i) = stats.f_measure;
    simulation_time(i) = stats.simulation_time;

end

cd(REFERENCE_PATH);

% Accuracy
[Peak, PeakIdx] = findpeaks(accuracy);
figure;
plot(accuracy)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Accuracy of Simulations')
ylabel('Accuracy')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'accuracy'); 

% Recall
[Peak, PeakIdx] = findpeaks(recall);
figure;
plot(recall)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Recall of Simulations')
ylabel('Recall')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'recall'); 

% Precision
[Peak, PeakIdx] = findpeaks(precision);
figure;
plot(precision)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Precision of Simulations')
ylabel('Precision')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'precision'); 

% Prevalence
[Peak, PeakIdx] = findpeaks(prevalence);
figure;
plot(prevalence)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Prevalence of Simulations')
ylabel('Prevalence')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'prevalence'); 

% Sensitivity
[Peak, PeakIdx] = findpeaks(sensitivity);
figure;
plot(sensitivity)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Sensitivity of Simulations')
ylabel('Sensitivity')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'sensitivity');

% Specificity
[Peak, PeakIdx] = findpeaks(specificity);
figure;
plot(specificity)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Specificity of Simulations')
ylabel('Specificity')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'specificity'); 

% F-Measure
[Peak, PeakIdx] = findpeaks(f_measure);
figure;
plot(f_measure)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('F-Measure of Simulations')
ylabel('F-Measure')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'f_measure'); 

% Simulation Time
[Peak, PeakIdx] = findpeaks(simulation_time);
figure;
plot(simulation_time)
text(X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak))

title('Time of Simulations')
ylabel('Time (s)')
xlabel('Simulation')

save_png(REFERENCE_PATH, 'f_measure'); 

%EOF