
rng(666); % For reproducibility

global REFERENCE_PATH
global SIMULATION_COUNTER
SIMULATION_COUNTER = 1;

backup_reference_path = REFERENCE_PATH;
%{
% --------------
% Pre-Processing
% Purpose: compare normalized VS non-normalized results
REFERENCE_PATH = sprintf('%s/s1_pre_processing', backup_reference_path);
disp('Pre-Processing simulations...');
run('interesting_simulations/s1_pre_processing');
%}
%{
% -----------------
% Feature Selection
% Purpose: compare the results of using different types of feature
% selection ( all can be (in)active ).
REFERENCE_PATH = sprintf('%s/s2_feature_selection', backup_reference_path);
disp('Feature Selection simulations...');
run('interesting_simulations/s2_feature_selection');
%}

% -----------------
% Feature Reduction
% Purpose: compare the results of different methods of feature reduction
% and additional feature reduction
REFERENCE_PATH = sprintf('%s/s3_feature_reduction', backup_reference_path);
disp('Feature Reduction simulations...');
run('interesting_simulations/s3_feature_reduction');

%{
% ----------
% Classifier
% Purpose: compare the results of different classifiers & different training ratios
REFERENCE_PATH = sprintf('%s/s4_classifier', backup_reference_path);
disp('Classifier simulations...');
run('interesting_simulations/s4_classifier');
%}

REFERENCE_PATH = backup_reference_path;

disp('---------')
disp('Finished!')
disp('---------')

%EOF