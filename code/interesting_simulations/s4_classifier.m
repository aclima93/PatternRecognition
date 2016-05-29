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

global VOTER_FLAG
global C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG
global C2_MATLAB_LDC_FLAG C2_EDC_FLAG C2_MDC_FLAG C2_MATLAB_DT_FLAG C2_SVM_FLAG C2_KNN_FLAG
global C3_MATLAB_LDC_FLAG C3_EDC_FLAG C3_MDC_FLAG C3_MATLAB_DT_FLAG C3_SVM_FLAG C3_KNN_FLAG

global NUM_ITERATIONS
global SIMULATION_COUNTER ITERATION_COUNTER

X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;

TRAINING_RATIO = 0.70;
STRATIFIED_FLAG = 1;

NORMALIZE_FLAG = 1;

FEATURE_SELECTION_FLAG = 1;
X_COR_COV_FLAG = 1;
XY_COR_COV_FLAG = 1;
KRUSKAL_WALLIS_FLAG = 1;

FEATURE_REDUCTION_FLAG = 1;
PCA_FLAG = 1;
LDA_FLAG = 0;
PCA_LDA_FLAG = 0;
LDA_PCA_FLAG = 0;

KAISER_CRITERIA_FLAG = 0;
SCREE_TEST_FLAG = 1;


VOTER_FLAG = 0;
% Purpose: compare the results of different classifiers
permutations3 = num2cell(unique(perms([1,0,0,0,0,0]), 'rows'));
[r3,~] = size(permutations3);
for i3 = 1:r3
    [C1_MATLAB_LDC_FLAG, C1_EDC_FLAG, C1_MDC_FLAG, C1_MATLAB_DT_FLAG, C1_SVM_FLAG, C1_KNN_FLAG] = permutations3{i3,:};
    
    
    for ITERATION_COUNTER = 1:NUM_ITERATIONS
        run('../main_script');
    end
    SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
    
end

% Purpose: compare the results of different classifiers
% using a triple modular redundancy voter
VOTER_FLAG = 1;
permutations5 = num2cell(unique(perms([1,1,1,0,0,0]), 'rows'));
[r5,~] = size(permutations5);
for i5 = 1:r5
    
    temp_i = find( [permutations5{i5,:}] == 1);
    
    temp_permut1 = num2cell([0,0,0,0,0,0]);
    temp_permut2 = temp_permut1;
    temp_permut3 = temp_permut2;
    
    temp_permut1{temp_i(1)} = 1;
    [C1_MATLAB_LDC_FLAG, C1_EDC_FLAG, C1_MDC_FLAG, C1_MATLAB_DT_FLAG, C1_SVM_FLAG, C1_KNN_FLAG] = temp_permut1{:};
    temp_permut2{temp_i(2)} = 1;
    [C2_MATLAB_LDC_FLAG, C2_EDC_FLAG, C2_MDC_FLAG, C2_MATLAB_DT_FLAG, C2_SVM_FLAG, C2_KNN_FLAG] = temp_permut2{:};
    temp_permut3{temp_i(3)} = 1;
    [C3_MATLAB_LDC_FLAG, C3_EDC_FLAG, C3_MDC_FLAG, C3_MATLAB_DT_FLAG, C3_SVM_FLAG, C3_KNN_FLAG] = temp_permut3{:};
    
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