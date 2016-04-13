function [ lda_out ] = linear_discriminant_analysis( data )
%LINEAR_DISCRIMINANT_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

lda_out = struct;

for new_dim = 1:data.dim
    
    model = lda(data, new_dim);
    data_projection = linproj(data.X, model);

    % Plot the data pattern according to the PCA model
    figure
    ppatterns(data_projection);
    title( strcat('LDA ', num2str(new_dim)) )

    lda_out.(strcat('new_dim_', num2str(new_dim))) = struct('model', model, 'data_projection', data_projection, 'y', data.y);
    
end

end
%EOF