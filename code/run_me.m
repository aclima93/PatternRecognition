close all

% get data from datasets
data = load('dataset.mat');

% analyse dataset
[model, out_data] = analyse_data(data.X, data.y, data.labels);