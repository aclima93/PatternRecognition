function [ lda_data ] = linear_discriminant_analysis( data )
%LINEAR_DISCRIMINANT_ANALYSIS Summary of this function goes here
%   Detailed explanation goes here

% LDA -> new dim = num classes -1
new_dim = length(unique(data.y)) - 1;

model = lda(data, new_dim);
data_projection = linproj(data.X, model);

lda_data = data;
lda_data.X = data_projection;
lda_data.dim = new_dim;   

end
%EOF