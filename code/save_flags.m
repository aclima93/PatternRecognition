function [  ] = save_flags( )
%CONCAT_FLAGS Summary of this function goes here
%   Detailed explanation goes here

% load variables

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

configuration = struct;

configuration(:).UI_MODE = UI_MODE;
configuration(:).SAVE_FIG_FLAG = SAVE_FIG_FLAG;
configuration(:).DATASET_PATH = DATASET_PATH;
configuration(:).VISUALIZE_DATA_FLAG = VISUALIZE_DATA_FLAG;

configuration(:).NORMALIZE_FLAG = NORMALIZE_FLAG;

configuration(:).FEATURE_SELECTION_FLAG = FEATURE_SELECTION_FLAG;
configuration(:).X_COR_COV_FLAG = X_COR_COV_FLAG;
configuration(:).X_COR_COV_THRESHOLD_FLAG = X_COR_COV_THRESHOLD_FLAG;
configuration(:).XY_COR_COV_FLAG = XY_COR_COV_FLAG;
configuration(:).XY_COR_COV_THRESHOLD_FLAG = XY_COR_COV_THRESHOLD_FLAG;
configuration(:).KRUSKAL_WALLIS_FLAG = KRUSKAL_WALLIS_FLAG;
configuration(:).KRUSKAL_WALLIS_THRESHOLD_FLAG = KRUSKAL_WALLIS_THRESHOLD_FLAG;

configuration(:).FEATURE_REDUCTION_FLAG = FEATURE_REDUCTION_FLAG;
configuration(:).PCA_FLAG = PCA_FLAG;
configuration(:).LDA_FLAG = LDA_FLAG;
configuration(:).PCA_LDA_FLAG = PCA_LDA_FLAG;
configuration(:).LDA_PCA_FLAG = LDA_PCA_FLAG;
configuration(:).KAISER_CRITERIA_FLAG = KAISER_CRITERIA_FLAG;
configuration(:).KAISER_CRITERIA_THRESHOLD = KAISER_CRITERIA_THRESHOLD;
configuration(:).SCREE_TEST_FLAG = SCREE_TEST_FLAG;
configuration(:).SCREE_TEST_THRESHOLD = SCREE_TEST_THRESHOLD;

configuration(:).STRATIFIED_FLAG = STRATIFIED_FLAG;
configuration(:).TRAINING_RATIO = TRAINING_RATIO;

configuration(:).MATLAB_LDC_FLAG = MATLAB_LDC_FLAG;
configuration(:).EDC_FLAG = EDC_FLAG;
configuration(:).MDC_FLAG = MDC_FLAG;
configuration(:).MATLAB_LDC_FLAG = MATLAB_DT_FLAG;

% save flags struct into the specified path

global SIMULATION_PATH

save( strcat(SIMULATION_PATH, '/configuration.mat'), 'configuration' );

end
%EOF
