function [  ] = linear_discriminant_analysis( data )
%LINEAR_DISCRIMINANT_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

% Plot the data pattern according to the PCA model
model = lda(data);
data_projection = linproj(data.X, model);
figure
ppatterns(data_projection);

end
%EOF