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

global VOTER_FLAG
global C1_MATLAB_LDC_FLAG C1_EDC_FLAG C1_MDC_FLAG C1_MATLAB_DT_FLAG C1_SVM_FLAG C1_KNN_FLAG
global C2_MATLAB_LDC_FLAG C2_EDC_FLAG C2_MDC_FLAG C2_MATLAB_DT_FLAG C2_SVM_FLAG C2_KNN_FLAG
global C3_MATLAB_LDC_FLAG C3_EDC_FLAG C3_MDC_FLAG C3_MATLAB_DT_FLAG C3_SVM_FLAG C3_KNN_FLAG

global APPLICATION_FLAG
global APPLICATION_DATASET_PATH

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

configuration(:).VOTER_FLAG = VOTER_FLAG;

configuration(:).C1_MATLAB_LDC_FLAG = C1_MATLAB_LDC_FLAG;
configuration(:).C1_EDC_FLAG = C1_EDC_FLAG;
configuration(:).C1_MDC_FLAG = C1_MDC_FLAG;
configuration(:).C1_MATLAB_DT_FLAG = C1_MATLAB_DT_FLAG;
configuration(:).C1_SVM_FLAG = C1_SVM_FLAG;
configuration(:).C1_KNN_FLAG = C1_KNN_FLAG;

configuration(:).C2_MATLAB_LDC_FLAG = C2_MATLAB_LDC_FLAG;
configuration(:).C2_EDC_FLAG = C2_EDC_FLAG;
configuration(:).C2_MDC_FLAG = C2_MDC_FLAG;
configuration(:).C2_MATLAB_DT_FLAG = C2_MATLAB_DT_FLAG;
configuration(:).C2_SVM_FLAG = C2_SVM_FLAG;
configuration(:).C2_KNN_FLAG = C2_KNN_FLAG;

configuration(:).C3_MATLAB_LDC_FLAG = C3_MATLAB_LDC_FLAG;
configuration(:).C3_EDC_FLAG = C3_EDC_FLAG;
configuration(:).C3_MDC_FLAG = C3_MDC_FLAG;
configuration(:).C3_MATLAB_DT_FLAG = C3_MATLAB_DT_FLAG;
configuration(:).C3_SVM_FLAG = C3_SVM_FLAG;
configuration(:).C3_KNN_FLAG = C3_KNN_FLAG;

% save flags struct into the specified path

global SIMULATION_PATH

save( strcat(SIMULATION_PATH, '/configuration.mat'), 'configuration' );

end
%EOF
