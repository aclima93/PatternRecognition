num_data = 10000;
dim = 23;
new_X = zeros(dim, num_data);

for i = 1:dim
    new_X(i, :) = std(X(i,:)).*randn(1, num_data) + mean(X(i,:));
end

new_X = round(new_X);

X = new_X;