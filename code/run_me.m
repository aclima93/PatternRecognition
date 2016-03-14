close all

% get data from datasets
data = load('dataset.mat');

% analyse dataset
[model, out_data] = pricipal_component_analysis(data.X, data.y, data.labels);