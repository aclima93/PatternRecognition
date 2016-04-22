function [ pca_data ] = principal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model

global KAISER_TEST_FLAG KAISER_TEST_THRESHOLD
global SCREE_TEST_FLAG SCREE_TEST_THRESHOLD

model = pca(data.X);
data_projection = linproj(data.X, model);

% new dim -> kaiser test output OR Scree Test
if KAISER_TEST_FLAG
    % Kaiser Criterion
    new_dim = length(find(model.eigval >= KAISER_TEST_THRESHOLD));
elseif SCREE_TEST_FLAG
    % Scree Test
    proportion_of_variance = cumsum(model.eigval) ./ sum(model.eigval);
    new_dim = length(find(proportion_of_variance >= SCREE_TEST_THRESHOLD));
else
    % same number of dimensions
    new_dim = data.dim;
end

pca_data = data;
pca_data.X = data_projection(1:new_dim,:);
pca_data.dim = new_dim;

end
%EOF