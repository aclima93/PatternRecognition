function [ pca_data ] = principal_component_analysis( data )
%ANALYSE_DATA
%   (http://www.mathworks.com/help/stats/principal-component-analysis-pca.html)
%   Perform PCA (Principal Component Analysis) of the data and plot with the
%   corresponding model
% extra info: https://documents.software.dell.com/statistics/textbook/principal-components-factor-analysis

global KAISER_CRITERIA_FLAG KAISER_CRITERIA_THRESHOLD 
global SCREE_TEST_FLAG SCREE_TEST_THRESHOLD;

model = pca(data.X);
data_projection = linproj(data.X, model);

% new dim -> kaiser test output OR Scree Test
% The Kaiser criterion sometimes retains too many factors, 
% while the Scree test sometimes retains too few.

if KAISER_CRITERIA_FLAG
    % The Kaiser criterion. First, we can retain only factors with 
    % eigenvalues greater than 1. In essence this is like saying that, 
    % unless a factor extracts at least as much as the equivalent of one 
    % original variable, we drop it.
    new_dim = length(find(model.eigval >= KAISER_CRITERIA_THRESHOLD));
elseif SCREE_TEST_FLAG
    % Scree Test
    proportion_of_variance = cumsum(model.eigval) ./ sum(model.eigval);
    new_dim = length(find(proportion_of_variance >= SCREE_TEST_THRESHOLD));
else
    % same number of dimensions
    new_dim = data.dim;
end

if new_dim < 1
    new_dim = 1;
end

pca_data = data;
pca_data.X = data_projection(1:new_dim,:);
pca_data.dim = new_dim;

end
%EOF