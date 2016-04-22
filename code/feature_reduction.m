% ----------------- %
% Feature Reduction %
% ----------------- %

PCA_FLAG = 0;
LDA_FLAG = 0;
PCA_LDA_FLAG = 1;
LDA_PCA_FLAG = 0;

reduction_data = struct;

if PCA_FLAG
    
    % ----------------------------
    % Principal Component Analysis
    disp('Performing PCA...');
    pca_out = pricipal_component_analysis(data);
    reduction_data = pca_out;
    
elseif LDA_FLAG
    
    % ----------------------------
    % Linear Discriminant Analysis
    disp('Performing LDA...');
    lda_out = linear_discriminant_analysis(data);
    reduction_data = lda_out;
    
elseif PCA_LDA_FLAG
    
    disp('Performing PCA and LDA...');
    
    % ----------------------------
    % Principal Component Analysis
    pca_out = pricipal_component_analysis(data);
    pca_labels = fieldnames(pca_out);
    
    for n = 1:length(pca_labels)
       
        % ----------------------------
        % Linear Discriminant Analysis
        lda_out = linear_discriminant_analysis( pca_out.(pca_labels{n}) );
        lda_labels = fieldnames(lda_out);
        
        for m = 1:length(lda_labels)
        
            reduction_data.( sprintf('%s_%s', pca_labels{n}, lda_labels{m} ) ) = lda_out.(lda_labels{m});
            
        end
        
    end
    
elseif LDA_PCA_FLAG
    
    disp('Performing LDA and PCA...');
    
    % ----------------------------
    % Linear Discriminant Analysis
    lda_out = linear_discriminant_analysis(data);
    lda_labels = fieldnames(lda_out);
    
    for n = 1:length(lda_labels)
       
        % ----------------------------
        % Principal Component Analysis
        pca_out = principal_component_analysis( lda_out.(lda_labels{n}) );
        pca_labels = fieldnames(pca_out);
        
        for m = 1:length(pca_labels)
        
            reduction_data.( sprintf('%s_%s', lda_labels{n}, pca_labels{m} ) ) = pca_out.(pca_labels{m});
            
        end
        
    end

end

% TODO: Skew and Skree (?) tests to choose min number of components and
% only do for that range [min_dim, cur_dim]

%EOF