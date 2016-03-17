function [ pca_out ] = pricipal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

% get covariance matrix of data
cov_X = cov(data.X);

figure
imagesc(cov_X)
ax = gca;
ax.XTickLabel = data.labels;
ax.YTickLabel = data.labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Feature Covariance')

% get correlation matrix of data
cor_X = corrcoef(data.X);

figure
imagesc(cor_X)
ax = gca;
ax.XTickLabel = data.labels;
ax.YTickLabel = data.labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Feature Correlation')

% perform PCA based on covariance matrix of fata
[coeff, latent, explained] = pcacov(cov_X);

% plot the cummulative explanation percentage depending on the number of
% Pcincipal Components considered
pc_cumsum = cumsum(explained*100)./sum(explained*100);

% and find the index where it crosses p%
p = 0.8;
indexAtPercentage = find(pc_cumsum >= p, 1, 'first');

figure
hold on
plot(pc_cumsum)
plot([0, indexAtPercentage], [p, p], 'red')
plot([indexAtPercentage, indexAtPercentage], [0, p], 'red')
hold off
ylabel('Explanation Percentage')
xlabel('Number of Components considered')
title('Cummulative explanation percentage of Components')

% plot the coefficients that each component attributes to each feature
%figure
%surf(coeff)
%ax = gca;
%ax.YTickLabel = data.labels;
%ylabel('Feature')
%xlabel('Principal Component')
%zlabel('Feature Coefficient')
%title('Linearized Component Feature Coefficients')

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