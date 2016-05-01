function [ kruskal_wallis_out ] = kruskal_wallis( X, y, labels )
%KRUSKAL_WALLIS_ANALYSIS
% http://support.minitab.com/en-us/minitab-express/1/help-and-how-to/modeling-statistics/anova/how-to/kruskal-wallis-test/interpret-the-results/key-results/

global SIMULATION_PATH
global VISUALIZE_DATA_FLAG

[N, ~] = size(X);
kruskal_wallis_out = zeros(N, 1);

for i = 1:N
    kruskal_wallis_out(i) = kruskalwallis(X(i, :), y, 'off');
end

% analysisng Kruskall-Wallis score for expected output
if VISUALIZE_DATA_FLAG
    figure('Visible','off')
    plot(kruskal_wallis_out)
    
    ax = gca;
    ax.XTickLabel = labels;
    ax.XTick = 1:length(ax.XTickLabel);
    ax.XTickLabelRotation = 90;
    xlabel('Feature')
    ylabel('Score')
    title('Kruskall-Wallis score for features with regard to Expected Output')
    
    save_png(strcat(SIMULATION_PATH, '/feature_selection'), 'kruskal_wallis'); close all;
end

end
%EOF