

% TODO: connect GUI choices to global flags
%{
global UI_MODE
UI_MODE = 1;

global SAVE_FIG_FLAG
SAVE_FIG_FLAG = 1;

% -------------- %
% Pre-Processing %
% -------------- %

%[FileName,PathName,FilterIndex] = uigetfile('*.mat');
%DATASET_PATH = sprintf('%s%s', PathName, FileName);
DATASET_PATH = '../data/dataset.mat';

global VISUALIZE_DATA_FLAG
VISUALIZE_DATA_FLAG = 0;

global NORMALIZE_FLAG
NORMALIZE_FLAG = 1;

% ----------------- %
% Feature Selection %
% ----------------- %

global FEATURE_SELECTION_FLAG
FEATURE_SELECTION_FLAG = 1;

global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
X_COR_COV_FLAG = 1;
X_COR_COV_THRESHOLD_FLAG = 0.9;

global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
XY_COR_COV_FLAG = 1;
XY_COR_COV_THRESHOLD_FLAG = 0.5;

global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG
KRUSKAL_WALLIS_FLAG = 1;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

% ----------------- %
% Feature Reduction %
% ----------------- %

global FEATURE_REDUCTION_FLAG
FEATURE_REDUCTION_FLAG = 1;

global PCA_FLAG LDA_FLAG PCA_LDA_FLAG LDA_PCA_FLAG
PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 1;
LDA_PCA_FLAG = 0;

global KAISER_CRITERIA_FLAG KAISER_CRITERIA_THRESHOLD
KAISER_CRITERIA_FLAG = 1;
KAISER_CRITERIA_THRESHOLD = 1;

global SCREE_TEST_FLAG SCREE_TEST_THRESHOLD
SCREE_TEST_FLAG = 0;
SCREE_TEST_THRESHOLD = 0.90;

% ------------------- %
% Performance Results %
% ------------------- %

global TRAINING_RATIO
TRAINING_RATIO = 0.7;

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
MATLAB_LDC_FLAG = 0;
EDC_FLAG = 1;
MDC_FLAG = 0;
%}

% TODO: set flags for multiple tests

global UI_MODE
global SAVE_FIG_FLAG
global DATASET_PATH
global VISUALIZE_DATA_FLAG
global NORMALIZE_FLAG
global FEATURE_SELECTION_FLAG
global X_COR_COV_FLAG
global X_COR_COV_THRESHOLD_FLAG
global XY_COR_COV_FLAG
global XY_COR_COV_THRESHOLD_FLAG
global KRUSKAL_WALLIS_FLAG
global KRUSKAL_WALLIS_THRESHOLD_FLAG
global FEATURE_REDUCTION_FLAG
global PCA_FLAG LDA_FLAG PCA_LDA_FLAG LDA_PCA_FLAG
global KAISER_CRITERIA_FLAG KAISER_CRITERIA_THRESHOLD
global SCREE_TEST_FLAG SCREE_TEST_THRESHOLD
global STRATIFIED_FLAG
global TRAINING_RATIO
global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG

% debug var
global SIMULATION_COUNTER
SIMULATION_COUNTER = 1;

% Constant Variables
UI_MODE = 0;
SAVE_FIG_FLAG = 1;
DATASET_PATH = '../data/dataset.mat';
VISUALIZE_DATA_FLAG = 0;

KAISER_CRITERIA_THRESHOLD = 1;
SCREE_TEST_THRESHOLD = 0.90;
KRUSKAL_WALLIS_THRESHOLD_FLAG = 0.05;

% -------------- %
% Pre-Processing %
% -------------- %

for NORMALIZE_FLAG = 0:1
    
    % ----------------- %
    % Feature Selection %
    % ----------------- %
    
    for FEATURE_SELECTION_FLAG = 0:1
        
        % all can be (in)active
        permutaions4 = num2cell(unique(nchoosek([0,1,0,1,0,1], 3), 'rows'));
        [r4,~] = size(permutaions4);
        for i4 = 1:r4
            [X_COR_COV_FLAG, XY_COR_COV_FLAG, KRUSKAL_WALLIS_FLAG] = permutaions4{i4,:};
            
            for X_COR_COV_THRESHOLD_FLAG = 0.8:0.1:1
                for XY_COR_COV_THRESHOLD_FLAG = 0.8:0.1:1
                    
                    
                    % ----------------- %
                    % Feature Reduction %
                    % ----------------- %
                    
                    for FEATURE_REDUCTION_FLAG = 0:1
                        
                        % only one is active
                        permutaions1 = num2cell(unique(perms([0,0,0,1]), 'rows'));
                        [r1,~] = size(permutaions1);
                        for i1 = 1:r1
                            [PCA_FLAG, LDA_FLAG, PCA_LDA_FLAG, LDA_PCA_FLAG] = permutaions1{i1,:};
                            
                            % only one is active
                            permutaions2 = num2cell(unique(perms([0,1]), 'rows'));
                            [r2,~] = size(permutaions2);
                            for i2 = 1:r2
                                [KAISER_CRITERIA_FLAG, SCREE_TEST_FLAG] = permutaions2{i2,:};
                                
                                
                                
                                % ------------------- %
                                % Performance Results %
                                % ------------------- %
                                
                                for STRATIFIED_FLAG = 0:1
                                    
                                    for TRAINING_RATIO = 0.65:0.05:0.75
                                        
                                        % only one is active
                                        permutaions3 = num2cell(unique(perms([0,0,1]), 'rows'));
                                        [r3,~] = size(permutaions3);
                                        for i3 = 1:r3
                                            [MATLAB_LDC_FLAG, EDC_FLAG, MDC_FLAG] = permutaions3{i3,:};
                                            
                                            disp(SIMULATION_COUNTER)
                                            
                                            % run for this configuration
                                            run('main_script');
                                            
                                            SIMULATION_COUNTER = SIMULATION_COUNTER + 1;
                                            
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
