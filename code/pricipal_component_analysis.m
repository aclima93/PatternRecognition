function [ pca_out ] = pricipal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

% Plot the data pattern according to the PCA model
model = pca(data.X);
data_projection = linproj(data.X, model);
figure
ppatterns(data_projection);
xlabel('pc')
set(gca, 'ytick', [])

pca_covariance = struct('coeff', coeff, 'latent', latent, 'explained', explained);
pca_out = struct('covariance', cov_X, 'correlation', cor_X, 'pca_covariance', pca_covariance, 'pca_model', model, 'data_projection', data_projection);

end
%EOF