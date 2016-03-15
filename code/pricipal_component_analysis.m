function [ ] = pricipal_component_analysis( X, labels )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model


% get covariance matrix of data
cov_X = cov(X);

figure
imagesc(cov_X)
ax = gca;
ax.XTickLabel = labels;
ax.YTickLabel = labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Covariance Matrix')

% perform PCA based on covariance matrix of fata
[coeff, latent, explained] = pcacov(cov_X);

% plot the cummulative explanation percentage depending on the number of
% Pcincipal Components considered
pc_cumsum = cumsum(explained*100)./sum(explained*100);

% and find the index where it crosses 90%
indexAt90Percent = find(pc_cumsum >= 0.9, 1, 'first');

figure
hold on
plot(pc_cumsum)
plot([1, indexAt90Percent], [0.9, 0.9], 'red')
plot([indexAt90Percent, indexAt90Percent], [0, 0.9], 'red')
hold off
ylabel('Explanation Percentage')
xlabel('Number of PCs considered')
title('Cummulative explanation percentage of Principal Components')

% Plot the data pattern according to the PCA model
%data_projection = linproj(X, model);
%figure
%ppatterns(data_projection);
%xlabel('pc')
%set(gca, 'ytick', [])

end

