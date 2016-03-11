close all

% get data from datasets
data = load('epilepsy_powers.mat');
X = data.caract;
y = data.class;

% analyse dataset
[model, out_data] = analyse_data(X, y);