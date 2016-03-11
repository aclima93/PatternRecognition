function [ model, data_projection ] = analyse_data( X, y )
%ANALYSE_DATA 
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%
%   X == data
%   y == class
%
%   - Plot the data
%   - Plot the normalized data
%   - Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

    [num_data, num_features] = size(X)

    % Plot features of data
    for j = 1:num_features
        figure
        hold on
        scatter(1:num_data, X(:,j))
        plot(1:num_data, y)
        hold off
    end

    % Normalize data
    [~, ~, norm_X] = scalestd(num_data, X);

    % Plot normalized data
    for i = 1:norm_X
        figure
        hold on
        scatter(1:num_data, norm_X(i,:))
        plot(1:num_data, y)
        hold off
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

