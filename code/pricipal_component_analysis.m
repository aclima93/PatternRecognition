function [ pca_out ] = pricipal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

pca_out = struct;

for new_dim = 1:data.dim

    model = pca(data.X, new_dim);
    data_projection = linproj(data.X, model);
    
    % Plot the data pattern according to the PCA model
    figure('Visible','off')
    ppatterns(data_projection);
    title( strcat('PCA ', num2str(new_dim)) )
    
    save_png('images/feature_reduction/PCA', strcat('PCA_', num2str(new_dim))); close all;

    pca_out.(strcat('new_dim_', num2str(new_dim))) = struct('model', model, 'data_projection', data_projection, 'y', data.y);
    
end

end
%EOF