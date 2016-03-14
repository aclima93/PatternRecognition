function [ model, data_projection ] = pricipal_component_analysis( X, y, labels)
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%
%   X == data
%   y == class
%   labels == String labels for data features
%
%   - Plot the data
%   - Plot the normalized data
%   - Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model


% flag to (dis/en)able plots
PLOT = 0;

[num_data, num_features] = size(X);

close all

if PLOT == 1
    % Plot features of data
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

% Normalize data
[~, ~, norm_X] = scalestd(X);

if PLOT == 1
    % Plot normalized data
    for j = 1:num_features
        figure
        hold on
        scatter(1:num_data, norm_X(:,j))
        title(labels(j))
        hold off
    end
    
    pause;
    close all;
end

% PCA
model = pca(norm_X);

% Plot the data pattern according to the PCA model
data_projection = linproj(norm_X, model);
figure
ppatterns(data_projection);
xlabel('pc')
set(gca, 'ytick', [])

end

