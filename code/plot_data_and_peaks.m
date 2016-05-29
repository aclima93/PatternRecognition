function plot_data_and_peaks( X, title_str, x_label_str, y_label_str, path, filename)
%PLOT_DATA_AND_PEAKS Summary of this function goes here
%   Detailed explanation goes here

figure;
plot(X)

peaks_str = '';

% maxima
[max_value, max_idx] = max(X);
num_max = 1:length(max_idx);
for idx = num_max
    peaks_str = sprintf('%s\nMax %s = %f, %s = %d', peaks_str,  y_label_str, max_value(idx), x_label_str, max_idx(idx));
end

peaks_str = sprintf('%s\n', peaks_str);

% minima
[min_value, min_idx] = min(X);
num_min = 1:length(min_idx);
for idx = num_min
    peaks_str = sprintf('%s\nMin %s = %f, %s = %d', peaks_str, y_label_str, min_value(idx), x_label_str, min_idx(idx));
end

legend( peaks_str , 'Location', 'Best')

title(title_str)
xlabel(x_label_str)
ylabel(y_label_str)

[N, M] = size(X);
ax = gca;
ax.XTickLabel = 1:N;
ax.XTick = 1:length(ax.XTickLabel);

save_png(path, filename);

end

