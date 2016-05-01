function [ X_correlation_covariance_out ] = X_correlation_covariance( X, labels )
%CORRELATION Summary of this function goes here
%   Detailed explanation goes here

global SIMULATION_PATH
global VISUALIZE_DATA_FLAG

% get covariance matrix of data
cov_X = cov(X');

if VISUALIZE_DATA_FLAG
    figure('Visible','off')
    imagesc(cov_X)
    
    colorbar
    ax = gca;
    ax.XTickLabel = labels;
    ax.YTickLabel = labels;
    ax.YTick = 1:length(ax.YTickLabel);
    ax.XTick = 1:length(ax.XTickLabel);
    ax.XTickLabelRotation = 90;
    xlabel('Feature')
    ylabel('Feature')
    title('Feature Covariance')
    
    save_png(strcat(SIMULATION_PATH, '/feature_selection'), 'X_covariance'); close all;
end

% get correlation matrix of data
cor_X = corrcoef(X');

if VISUALIZE_DATA_FLAG
    figure('Visible','off')
    imagesc(cor_X)
    
    colorbar
    ax = gca;
    ax.XTickLabel = labels;
    ax.YTickLabel = labels;
    ax.YTick = 1:length(ax.YTickLabel);
    ax.XTick = 1:length(ax.XTickLabel);
    ax.XTickLabelRotation = 90;
    xlabel('Feature')
    ylabel('Feature')
    title('Feature Correlation')
    
    save_png(strcat(SIMULATION_PATH, '/feature_selection'), 'X_correlation'); close all;
end

X_correlation_covariance_out = struct('covariance', cov_X, 'correlation', cor_X);

end
%EOF