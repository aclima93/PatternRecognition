function [ X_correlation_covariance_out ] = X_correlation_covariance( X, labels )
%CORRELATION Summary of this function goes here
%   Detailed explanation goes here

% get covariance matrix of data
cov_X = cov(X');
figure
imagesc(cov_X)

ax = gca;
ax.XTickLabel = labels;
ax.YTickLabel = labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Feature Covariance') 

% get correlation matrix of data
cor_X = corrcoef(X');
figure
imagesc(cor_X)

ax = gca;
ax.XTickLabel = labels;
ax.YTickLabel = labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Feature Correlation')

X_correlation_covariance_out = struct('covariance', cov_X, 'correlation', cor_X);

end
%EOF