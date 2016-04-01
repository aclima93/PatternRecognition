function [ Xy_correlation_covariance_out ] = Xy_correlation_covariance( X, y, labels )
%EXPECTED_OUTPUT_CORRELATION_COVARIANCE Summary of this function goes here
%   Detailed explanation goes here

% get covariance matrix of data
cov_Xy = cov(X', y');

% get correlation matrix of data
cor_Xy = corrcoef(X', y');

% analysisng covariance with expected output
figure;
hold on
plot(cov_Xy)
plot(cor_Xy)
hold off
ax = gca;
ax.XTickLabel = labels;
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Score')
title('Feature Correlation and Covariance with regard to Expected Output')
legend('covariance', 'correlation')

Xy_correlation_covariance_out = struct('covariance', cov_Xy, 'correlation', cor_Xy);

end
%EOF
