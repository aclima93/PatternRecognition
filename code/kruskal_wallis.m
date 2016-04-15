function [ kruskal_wallis_out ] = kruskal_wallis( X, y, labels )
%KRUSKAL_WALLIS_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

[N, ~] = size(X);
kruskal_wallis_out = zeros(N, 1);

for i = 1:N
    kruskal_wallis_out(i) = kruskalwallis(X(i, :), y, 'off');
end

% analysisng Kruskall-Wallis score for expected output
%{
figure;
plot(kruskal_wallis_out)

ax = gca;
ax.XTickLabel = labels;
ax.XTick = 1:length(ax.XTickLabel);
ax.XTickLabelRotation = 90;
xlabel('Feature')
ylabel('Score')
title('Kruskall-Wallis score for features with regard to Expected Output')
%}

end
%EOF