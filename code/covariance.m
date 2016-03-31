function [ covariance_out ] = covariance( X, labels )
%CORRELATION Summary of this function goes here
%   Detailed explanation goes here

% get covariance matrix of data
cov_X = cov(X);
figure
imagesc(cov_X)

ax = gca;
ax.XTickLabel = labels;
ax.YTickLabel = labels;
set(ax.XTickLabel, 'Interpreter', 'none')
set(ax.YTickLabel, 'Interpreter', 'none')
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Feature')
title('Feature Covariance') 

pause;

covariance_out = struct('covariance', cov_X);

end

