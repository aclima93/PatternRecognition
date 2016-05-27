
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

global VOTER_FLAG
global C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG
global C2_MATLAB_LDC_FLAG C2_EDC_FLAG C2_MDC_FLAG C2_MATLAB_DT_FLAG C2_SVM_FLAG C2_KNN_FLAG
global C3_MATLAB_LDC_FLAG C3_EDC_FLAG C3_MDC_FLAG C3_MATLAB_DT_FLAG C3_SVM_FLAG C3_KNN_FLAG

global NUM_ITERATIONS
global SIMULATION_COUNTER ITERATION_COUNTER
SIMULATION_COUNTER = 1;

% Constant Variables
FEATURE_SELECTION_FLAG = 1;
X_COR_COV_THRESHOLD_FLAG = 0.90;
XY_COR_COV_THRESHOLD_FLAG = 0.25;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

FEATURE_REDUCTION_FLAG = 1;
KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;

STRATIFIED_FLAG = 1;
TRAINING_RATIO = 0.70;

% --------------------
% Pre-Processing Tests

% Purpose: compare normalized VS non-normalized results
for NORMALIZE_FLAG = 0:1
    
    % -----------------
    % Feature Selection
    
    % Purpose: compare the results of using different types of feature
    % selection ( all can be (in)active ).
    permutations4 = num2cell(unique(nchoosek([0,1,0,1,0,1], 3), 'rows'));
    [r4,~] = size(permutations4);
    for i4 = 1:r4
        [X_COR_COV_FLAG, XY_COR_COV_FLAG, KRUSKAL_WALLIS_FLAG] = permutations4{i4,:};
        
        % -----------------
        % Feature Reduction
        
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
                
                % ----------
                % Classifier
                
                VOTER_FLAG = 0;
                % Purpose: compare the results of different classifiers
                permutations3 = num2cell(unique(perms([1,0,0,0,0,0]), 'rows'));
                [r3,~] = size(permutations3);
                for i3 = 1:r3
                    [C1_MATLAB_LDC_FLAG, C1_EDC_FLAG, C1_MDC_FLAG, C1_MATLAB_DT_FLAG, C1_SVM_FLAG, C1_KNN_FLAG] = permutations3{i3,:};
                    

                    for ITERATION_COUNTER = 1:NUM_ITERATIONS
                        run('main_script');
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
                        run('main_script');
                    end
                    SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
                    
                end
                
            end
        end
    end
end

%}

% ------------------- %
% Performance Results %
% ------------------- %

run('performance_comparison');

disp('---------')
disp('Finished!')
disp('---------')

%EOF