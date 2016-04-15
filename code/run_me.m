close all

% ------------------ %
% Data Preprocessing %
% ------------------ %

% get data from datasets
data = load('data/dataset.mat');

norm_data = normalize_data( data );

%plot_data(data.X, data.labels, data.dim, data.num_data);
%plot_data(norm_data.X, norm_data.labels, norm_data.dim, norm_data.num_data);

% ----------------- %
% Feature Selection %
% ----------------- %

% --------------------------------
% Feature Selection for Redundancy

X_correlation_covariance_out = X_correlation_covariance(norm_data.X, norm_data.labels);

% find features that represent other features for correlations above 90%
redund_X_threshold = 0.9;
[N, ~] = size(norm_data.X);
representative = zeros(N,1);
represented = zeros(N,1);

for i = 1:N
    if ~represented(i)
        
        cols = find(X_correlation_covariance_out.correlation(i,:) >= redund_X_threshold);
        if ~isempty(cols)
        
            representative(i) = 1;
            represented( cols(cols ~= i) ) = 1;
        end
    end
end

% features that represent other features for correlations above 90%
idx_redund_X = find( representative == 1 );

% ------------------------------------------------------
% Feature Selection for Correlation with Expected Output

Xy_correlation_covariance_out = Xy_correlation_covariance(norm_data.X, norm_data.y, norm_data.labels);

% correlations above 50%
redu_X_threshold = 0.5;
idx_redu_X = find(Xy_correlation_covariance_out.correlation >= redu_X_threshold);

% -----
% TODO: Kruskal-Wallis results are shitty, at best...
% -----

% ----------------------------------------------------------------------
% Kruskal-Wallis parametric test discard features with p-score above 0.5
kruskal_wallis_out = kruskal_wallis(norm_data.X, norm_data.y, norm_data.labels);
kw_threshold = 0.05;
idx_kruskal_wallis = find(kruskal_wallis_out <= kw_threshold);

% --------------------------------------
% Feature Selection with all suggestions

if ~isempty(idx_redund_X) && ~isempty(idx_redu_X)
    idx = intersect(idx_redund_X, idx_redu_X);
elseif isempty(idx_redu_X)
    idx = idx_redund_X;
elseif isempty(idx_redund_X)
    idx = idx_redu_X;
else
    idx = idx_kruskal_wallis;
end
idx = intersect( idx, idx_kruskal_wallis);
redux_data = norm_data;
redux_data.X = redux_data.X(idx, :); 
redux_data.labels = redux_data.labels(idx); 
redux_data.dim = length(idx); 

% ----------------- %
% Feature Reduction %
% ----------------- %

% ----------------------------
% Principal Component Analysis
disp('PCA of normalized data');
pca_out = pricipal_component_analysis(redux_data);
close all;

% ----------------------------
% Linear Discriminant Analysis
disp('LDA of normalized data');
lda_out = linear_discriminant_analysis(redux_data);
close all;

% ----------------------------------------------------------------- %
% Dataset Split + Training and Testing + Classification Performance %
% ----------------------------------------------------------------- %

% tta: train_test_analysis
tta_out = struct;

% Normalized Data
tta_out.('norm_data') = train_test_analysis( norm_data.X, norm_data.y);

% Reduced Data
tta_out.('redux_data') = train_test_analysis( redux_data.X, redux_data.y);

% PCA Data
for i = 1:length(fieldnames(pca_out))
    first_stats = pca_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('pca_data_', num2str(i))) = train_test_analysis( first_stats.data_projection, first_stats.y);
end

% LDA Data
for i = 1:length(fieldnames(lda_out))
    first_stats = lda_out.(strcat('new_dim_', num2str(i)));
    tta_out.(strcat('lda_data_', num2str(i))) = train_test_analysis( first_stats.data_projection, first_stats.y);
end

% --------------------------- %
% Compare Performance Results %
% --------------------------- %

% for each dataset
tta_labels = fieldnames(tta_out);

% for each classifier

classifier_labels = fieldnames( tta_out.( tta_labels{1} ));
num_classifier_labels = length(classifier_labels);

% for each set of statistical results
%cpa_label_groups = {'Condition Analysis', 'Accuracy' 'True Condition', 'Prevalence', 'Predicted Condition', 'Diagnostic Analysis'};
%cpa_labels = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives', 'Accuracy', 'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate', 'Prevalence', 'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};

for i = 1:length(tta_labels)

    first_stats = tta_out.( tta_labels{i} ).( classifier_labels{1} ).cpa_out;
    
    condition_analysis = zeros( num_classifier_labels, length(first_stats.condition_analysis) );
    accuracy = zeros( num_classifier_labels, length(first_stats.accuracy) );
    true_condition = zeros( num_classifier_labels, length(first_stats.true_condition) );
    prevalence = zeros( num_classifier_labels, length(first_stats.prevalence) );
    predicted_condition = zeros( num_classifier_labels, length(first_stats.predicted_condition) );
    diagnostic_analysis = zeros( num_classifier_labels, length(first_stats.diagnostic_analysis) );
    
    for j = 1:num_classifier_labels
   
        stats = tta_out.( tta_labels{i} ).( classifier_labels{j} ).cpa_out;
        
        condition_analysis(j,:) = stats.condition_analysis;
        accuracy(j, :) = stats.accuracy;
        true_condition(j,:) = stats.true_condition;
        prevalence(j, :) = stats.prevalence;
        predicted_condition(j,:) = stats.predicted_condition;
        diagnostic_analysis(j,:) = stats.diagnostic_analysis;
        
    end
    
    % --------------------
    % Colormap Comparisons
    
    % Condition Analysis
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positives', 'False Positives', 'False Negatives', 'True Negatives'};
    xlabel('Condition Analysis')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(condition_analysis)
    
    % True Condition
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'True Positive Rate', 'False Negative Rate', 'False Positive Rate', 'True Negative Rate'};
    xlabel('True Condition')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(true_condition)
    
    % Predicted Condition
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Prediction Value', 'False Discovery Rate', 'False Omission Rate', 'Negative Predictive Value'};
    xlabel('Predicted Condition')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(predicted_condition)
    
    % Diagnostic Analysis
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = {'Positive Likelyhood Ratio', 'Negative Likelyhood Ratio', 'Diagnostic Odds Ratio'};
    xlabel('Diagnostic Analysis')
    ax.YTickLabel = classifier_labels;
    ylabel('Classifier')
    imagesc(diagnostic_analysis)
    
    % ------------------
    % Linear Comparisons
    
    % Accuracy
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    xlabel('Classifier')
    ylabel('Accuracy')
    plot(accuracy)
    
    % Prevalence
    figure;
    title(tta_labels{i})
    ax = gca;
    ax.XTickLabel = classifier_labels;
    xlabel('Classifier')
    ylabel('Prevalence')
    plot(prevalence)
    
    close all;
    
end

%EOF