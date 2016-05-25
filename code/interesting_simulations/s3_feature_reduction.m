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
% Feature Reduction
% Purpose: compare the results of different methods of feature reduction
% and additional feature reduction
disp('Feature Reduction simulations...');

%
%TODO: add previous best configs here
%

FEATURE_REDUCTION_FLAG = 1;
PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 0;
LDA_PCA_FLAG = 0;

for ITERATION_COUNTER = 1:30
    run('main_script');
end
SIMULATION_COUNTER = SIMULATION_COUNTER + 1;


% ------------------- %
% Performance Results %
% ------------------- %

run('../performance_comparison');

%EOF