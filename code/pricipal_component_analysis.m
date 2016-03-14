function [ model, data_projection ] = pricipal_component_analysis( X, y, labels)
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%
%   X == data
%   y == class
%   labels == String labels for data features
%
%   - Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model


% PCA
model = pca(X);

% Plot the data pattern according to the PCA model
data_projection = linproj(X, model);
figure
ppatterns(data_projection);
xlabel('pc')
set(gca, 'ytick', [])

end

