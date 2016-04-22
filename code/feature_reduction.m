% ----------------- %
% Feature Reduction %
% ----------------- %

global PCA_FLAG LDA_FLAG PCA_LDA_FLAG LDA_PCA_FLAG
global KAISER_TEST_FLAG KAISER_TEST_THRESHOLD SCREE_TEST_FLAG SCREE_TEST_THRESHOLD;

PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 1;
LDA_PCA_FLAG = 0;

KAISER_TEST_FLAG = 1;
KAISER_TEST_THRESHOLD = 1;
SCREE_TEST_FLAG = 0;
SCREE_TEST_THRESHOLD = 0.90;

if PCA_FLAG
    
    % ----------------------------
    % Principal Component Analysis
    disp('Performing PCA...');
    pca_out = principal_component_analysis(data);

    data = pca_out;
    
elseif LDA_FLAG
    
    % ----------------------------
    % Linear Discriminant Analysis
    disp('Performing LDA...');
    lda_out = linear_discriminant_analysis(data);

    data = lda_out;
    
elseif PCA_LDA_FLAG
    
    % ----------------------------
    % Principal Component Analysis
    disp('Performing PCA...');
    pca_out = principal_component_analysis(data);
    
    % ----------------------------
    % Linear Discriminant Analysis
    disp('Performing LDA...');
    lda_out = linear_discriminant_analysis(pca_out);
        
    data = lda_out;
    
elseif LDA_PCA_FLAG
    
    % ----------------------------
    % Linear Discriminant Analysis
    disp('Performing LDA...');
    lda_out = linear_discriminant_analysis(data);
    
    % ----------------------------
    % Principal Component Analysis
    disp('Performing PCA...');
    pca_out = principal_component_analysis(lda_out);
        
    data = pca_out;
    
end

%EOF