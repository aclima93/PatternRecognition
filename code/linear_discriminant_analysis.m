function [ lda_out ] = linear_discriminant_analysis( data )
%LINEAR_DISCRIMINANT_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

lda_out = struct;

for new_dim = 1:data.dim
    
    model = lda(data, new_dim);
    data_projection = linproj(data.X, model);
    
    lda_data = data;
    lda_data.X = data_projection;
    lda_data.dim = new_dim;
    
    lda_out.(strcat('lda_', num2str(new_dim))) = lda_data;
    
end

end
%EOF