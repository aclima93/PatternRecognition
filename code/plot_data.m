function [  ] = plot_data( X, labels )
%PLOT_DATA Summary of this function goes here
%   Detailed explanation goes here

% flag to (dis/en)able plots
PLOT = 0;

close all;

if PLOT == 1
    % Plot features of data
    disp('Plotting data...');
    for j = 1:num_features
        figure
        hold on
        scatter(1:num_data, X(:,j))
        title(labels(j))
        hold off
    end
    pause;
    close all;
end

end

