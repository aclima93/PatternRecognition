% ----------------- %
% Feature Reduction %
% ----------------- %

PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 1;
LDA_PCA_FLAG = 0;

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