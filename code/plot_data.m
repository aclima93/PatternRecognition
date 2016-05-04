function [  ] = plot_data( X, labels , dim, num_data)
%PLOT_DATA Summary of this function goes here
%   Detailed explanation goes here

global SIMULATION_PATH

% Plot features of data
disp('Plotting data...');
for j = 1:dim
    figure('Visible','off')
    scatter(1:num_data, X(j,:))
    t = title(labels(j));
    set(t, 'Interpreter', 'none')
    save_png(strcat(SIMULATION_PATH, '/data'), labels(j)); close all;
end

end

