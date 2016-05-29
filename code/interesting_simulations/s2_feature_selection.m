global NORMALIZE_FLAG

global FEATURE_SELECTION_FLAG
global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG

global FEATURE_REDUCTION_FLAG

global STRATIFIED_FLAG
global TRAINING_RATIO

global C1_EDC_FLAG

global NUM_ITERATIONS
global SIMULATION_COUNTER ITERATION_COUNTER

NORMALIZE_FLAG = 1;

FEATURE_SELECTION_FLAG = 1;
X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

FEATURE_REDUCTION_FLAG = 0;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

C1_EDC_FLAG = 1;


permutations1 = num2cell(unique(nchoosek([0,1,0,1,0,1], 3), 'rows'));
[r1,~] = size(permutations1);
for i1 = 1:r1
    [X_COR_COV_FLAG, XY_COR_COV_FLAG, KRUSKAL_WALLIS_FLAG] = permutations1{i1,:};
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