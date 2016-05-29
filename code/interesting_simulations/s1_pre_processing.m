global NORMALIZE_FLAG

global FEATURE_SELECTION_FLAG
global FEATURE_REDUCTION_FLAG

global STRATIFIED_FLAG
global TRAINING_RATIO 

global C1_EDC_FLAG

global NUM_ITERATIONS
global SIMULATION_COUNTER ITERATION_COUNTER

% no feature selection, no feature reduction, Matlab's LDC classifier
FEATURE_SELECTION_FLAG = 0;

FEATURE_REDUCTION_FLAG = 0;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

C1_EDC_FLAG = 1;


for i1 = 0:1
    NORMALIZE_FLAG = i1;

    for ITERATION_COUNTER = 1:NUM_ITERATIONS
        run('../main_script');
    end
    SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
end

% ------------------- %
% Performance Results %
% ------------------- %

run('../performance_comparison');

%EOF