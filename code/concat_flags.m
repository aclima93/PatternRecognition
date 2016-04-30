function [ string ] = concat_flags( )
%CONCAT_FLAGS Summary of this function goes here
%   Detailed explanation goes here

% load variables

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

string = '';

string = strcat(string, num2str(NORMALIZE_FLAG)); string = strcat(string, '_');

string = strcat(string, num2str(FEATURE_SELECTION_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(X_COR_COV_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(X_COR_COV_THRESHOLD_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(XY_COR_COV_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(XY_COR_COV_THRESHOLD_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(KRUSKAL_WALLIS_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(KRUSKAL_WALLIS_THRESHOLD_FLAG)); string = strcat(string, '_');

string = strcat(string, num2str(FEATURE_REDUCTION_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(PCA_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(LDA_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(PCA_LDA_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(LDA_PCA_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(KAISER_CRITERIA_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(KAISER_CRITERIA_THRESHOLD)); string = strcat(string, '_');
string = strcat(string, num2str(SCREE_TEST_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(SCREE_TEST_THRESHOLD)); string = strcat(string, '_');

string = strcat(string, num2str(STRATIFIED_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(TRAINING_RATIO)); string = strcat(string, '_');

string = strcat(string, num2str(MATLAB_LDC_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(EDC_FLAG)); string = strcat(string, '_');
string = strcat(string, num2str(MDC_FLAG)); string = strcat(string, '_');

end
%EOF
