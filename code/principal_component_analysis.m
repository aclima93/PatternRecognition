function [ pca_data ] = principal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

% PCA -> new dim = kaiser test output
new_dim = 5; % 

model = pca(data.X, new_dim);
data_projection = linproj(data.X, model);

pca_data = data;
pca_data.X = data_projection;
pca_data.dim = new_dim;

end
%EOF