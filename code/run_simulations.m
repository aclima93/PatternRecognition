
rng(666); % For reproducibility

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
SIMULATION_COUNTER = 1;

X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

% ----------------------------------------------------------------------- %
% Interesting tests to run:
% - Normalized vs No Pre-Processing
% - X vs Xy vs Kruskal-Wallis
% - PCA vs LDA vs (PCA & LDA) vs (LDA & PCA)
% ------ if PCA is in the winner:
% --- Kaiser Criteria vs Skree Test
% ----------------------------------------------------------------------- %
% total tests = (30*2) + (30*3) + (30*4) + (30*2) = 30 * 11 = 330 which is
% less than the current 900~ tests
% ----------------------------------------------------------------------- %

% --------------
% Pre-Processing
% Purpose: compare normalized VS non-normalized results
disp('Pre-Processing simulations...');

FEATURE_SELECTION_FLAG = 0;
FEATURE_REDUCTION_FLAG = 0;
MATLAB_LDC_FLAG = 1;

% no normalization
NORMALIZE_FLAG = 0;
for ITERATION_COUNTER = 1:30
    run('main_script');
end
SIMULATION_COUNTER = SIMULATION_COUNTER + 1;

% normalized
NORMALIZE_FLAG = 1;
for ITERATION_COUNTER = 1:30
    run('main_script');
end
SIMULATION_COUNTER = SIMULATION_COUNTER + 1;

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

% -----------------
% Feature Reduction
% Purpose: compare the results of different methods of feature reduction
disp('Feature Reduction simulations...');

FEATURE_REDUCTION_FLAG = 1;
PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 0;
LDA_PCA_FLAG = 0;





% ----------------------------
% Additional Feature Reduction
% Purpose: compare the results of different methods of additional
% feature reduction
disp('Additional Feature Selection simulations...');

NORMALIZE_FLAG = 1;
FEATURE_SELECTION_FLAG = 1;
FEATURE_REDUCTION_FLAG = 1;
PCA_FLAG = 1;
MATLAB_LDC_FLAG = 1;






% ----------
% Classifier
% Purpose: compare the results of different classifiers
disp('Classifier simulations...');

MATLAB_LDC_FLAG = 1;
EDC_FLAG = 0;
MDC_FLAG = 0;
MATLAB_DT_FLAG = 0;
SVN_FLAG = 0;
KNN_FLAG = 0;






% ------------------- %
% Performance Results %
% ------------------- %

run('performance_comparison');

%EOF