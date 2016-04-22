function [ pca_out ] = pricipal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

pca_out = struct;

for new_dim = 1:data.dim

    model = pca(data.X, new_dim);
    data_projection = linproj(data.X, model);

    pca_data = data;
    pca_data.X = data_projection;
    pca_data.dim = new_dim;
    
    pca_out.(strcat('pca_', num2str(new_dim))) = pca_data;
    
end

end
%EOF