function [ Xy_correlation_covariance_out ] = Xy_correlation_covariance( X, y, labels )
%EXPECTED_OUTPUT_CORRELATION_COVARIANCE Summary of this function goes here
%   Detailed explanation goes here

[N, ~] = size(X);

cov_Xy = zeros(N, 1);
cor_Xy = zeros(N, 1);

temp_y = y';

for i = 1:N
    temp_x = X(i, :)';
      
    % get covariance matrix of data
    temp_cov = cov(temp_x, temp_y);
    cov_Xy(i) = temp_cov(1,2);

    % get correlation matrix of data
    temp_cor = corrcoef(temp_x, temp_y);
    cor_Xy(i) = temp_cor(1,2);
end

% analysisng covariance with expected output
figure;
hold on
plot(cov_Xy)
plot(cor_Xy)
hold off
ax = gca;
ax.XTickLabel = labels;
ax.XTickLabelRotation = 90;
ax.XTick = 1:length(ax.XTickLabel);
xlabel('Feature')
ylabel('Score')
title('Feature Correlation and Covariance with regard to Expected Output')
legend('covariance', 'correlation')

Xy_correlation_covariance_out = struct('covariance', cov_Xy, 'correlation', cor_Xy);

end
%EOF
