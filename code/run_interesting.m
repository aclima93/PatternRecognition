
rng(666); % For reproducibility

global SIMULATION_COUNTER
SIMULATION_COUNTER = 1;

% --------------
% Pre-Processing
disp('Pre-Processing simulations...');
run('interesting_simulations/s1_pre_processing');

%{
% -----------------
% Feature Selection
disp('Feature Selection simulations...');
run('interesting_simulations/s2_feature_selection');

% -----------------
% Feature Reduction
disp('Feature Reduction simulations...');
run('interesting_simulations/s3_feature_reduction');

% ----------
% Classifier
disp('Classifier simulations...');
run('interesting_simulations/s4_classifier');
%}

%EOF