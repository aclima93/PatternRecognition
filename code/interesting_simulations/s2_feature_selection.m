global NORMALIZE_FLAG

global FEATURE_SELECTION_FLAG
global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG

global FEATURE_REDUCTION_FLAG
global PCA_FLAG
global LDA_FLAG
global PCA_LDA_FLAG
global LDA_PCA_FLAG
global KAISER_CRITERIA_FLAG
global KAISER_CRITERIA_THRESHOLD
global SCREE_TEST_FLAG
global SCREE_TEST_THRESHOLD

global STRATIFIED_FLAG
global TRAINING_RATIO

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
global MATLAB_DT_FLAG
global SVN_FLAG
global KNN_FLAG

global SIMULATION_COUNTER ITERATION_COUNTER

X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

% -----------------
% Feature Selection
% Purpose: compare the results of using different types of feature
% selection ( all can be (in)active ).
disp('Feature Selection simulations...');

NORMALIZE_FLAG = 1;
FEATURE_SELECTION_FLAG = 1;
FEATURE_REDUCTION_FLAG = 0;
MATLAB_LDC_FLAG = 1;

permutations1 = num2cell(unique(nchoosek([0,1,0,1,0,1], 3), 'rows'));
[r1,~] = size(permutations1);
for i1 = 1:r1
    [X_COR_COV_FLAG, XY_COR_COV_FLAG, KRUSKAL_WALLIS_FLAG] = permutations1{i1,:};
    for ITERATION_COUNTER = 1:30
        run('main_script');
    end
    SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
end


% ------------------- %
% Performance Results %
% ------------------- %

run('../performance_comparison');

%EOF