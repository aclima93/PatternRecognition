function [ model ] = pricipal_component_analysis( X, labels )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model


% PCA
covx = cov(X);
model = pcacov(covx);

% Plot the data pattern according to the PCA model
%data_projection = linproj(X, model);
%figure
%ppatterns(data_projection);
%xlabel('pc')
%set(gca, 'ytick', [])

end

