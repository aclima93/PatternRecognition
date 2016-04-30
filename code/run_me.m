

% TODO: connect GUI choices to global flags

global UI_MODE
UI_MODE = 1;

global SAVE_FIG_FLAG
SAVE_FIG_FLAG = 1;

% -------------- %
% Pre-Processing %
% -------------- %

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

global KAISER_TEST_FLAG KAISER_TEST_THRESHOLD 
KAISER_TEST_FLAG = 1;
KAISER_TEST_THRESHOLD = 1;

global SCREE_TEST_FLAG SCREE_TEST_THRESHOLD;
SCREE_TEST_FLAG = 0;
SCREE_TEST_THRESHOLD = 0.90;

% ------------------- %
% Performance Results %
% ------------------- %

global TRAINING_RATIO;
TRAINING_RATIO = 0.7;

global MATLAB_LDC_FLAG
global EDC_FLAG
global MDC_FLAG
MATLAB_LDC_FLAG = 0;
EDC_FLAG = 1;
MDC_FLAG = 0;

% TODO: set flags for multiple tests

run('main_script');