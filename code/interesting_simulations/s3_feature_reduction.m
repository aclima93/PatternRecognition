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

global C1_MATLAB_LDC_FLAG


global NUM_ITERATIONS
global SIMULATION_COUNTER ITERATION_COUNTER

NORMALIZE_FLAG = 1;

X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

FEATURE_SELECTION_FLAG = 1;

%
%TODO: add previous best configs here
%

FEATURE_REDUCTION_FLAG = 1;
KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;

C1_MATLAB_LDC_FLAG = 1;

% Purpose: compare the results of different methods of feature reduction
permutations1 = num2cell(unique(perms([1,0,0,0,0]), 'rows'));
[r1,~] = size(permutations1);
for i1 = 1:r1
    [~, PCA_FLAG, LDA_FLAG, PCA_LDA_FLAG, LDA_PCA_FLAG] = permutations1{i1,:};
    
    % Purpose: compare the results of different methods of 
    % additional feature reduction
    permutations2 = num2cell(unique(perms([1,0,0]), 'rows'));
    [r2,~] = size(permutations2);
    for i2 = 1:r2
        [~, KAISER_CRITERIA_FLAG, SCREE_TEST_FLAG] = permutations2{i2,:};
    
        for ITERATION_COUNTER = 1:NUM_ITERATIONS
            run('../main_script');
        end
        SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
    end
end

% ------------------- %
% Performance Results %
% ------------------- %

run('../performance_comparison');

%EOF