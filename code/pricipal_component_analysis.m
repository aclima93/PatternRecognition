function [ ] = pricipal_component_analysis( X, labels )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model


% get covariance matrix of data
cov_X = cov(X);

figure
imagesc(cov_X)
title('Covariance matrix of X')

% perform PCA based on covariance matrix of fata
[coeff, eigenvalues,explained_percent] = pcacov(cov_X);


% Plot the data pattern according to the PCA model
%data_projection = linproj(X, model);
%figure
%ppatterns(data_projection);
%xlabel('pc')
%set(gca, 'ytick', [])

end

