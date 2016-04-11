function [ kruskal_wallis_out ] = kruskal_wallis( X, y, labels )
%KRUSKAL_WALLIS_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

[p,tbl,stats] = kruskalwallis(X, y);

kruskal_wallis_out = struct('p', p, 'ANOVA_table', tbl, 'statistics', stats);

end
%EOF