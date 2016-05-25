global NORMALIZE_FLAG

global FEATURE_SELECTION_FLAG
global FEATURE_REDUCTION_FLAG

global STRATIFIED_FLAG
global TRAINING_RATIO 

global SVM_FLAG

global SIMULATION_COUNTER ITERATION_COUNTER

% no feature selection, no feature reduction, matlab's SVM classifier
FEATURE_SELECTION_FLAG = 0;
FEATURE_REDUCTION_FLAG = 0;
SVM_FLAG = 1;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

for i1 = 0:1
    NORMALIZE_FLAG = i1;

    for ITERATION_COUNTER = 1:30
        run('../main_script');
    end
    SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
end

% ------------------- %
% Performance Results %
% ------------------- %

run('../performance_comparison');

%EOF