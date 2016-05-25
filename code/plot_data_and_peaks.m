function plot_data_and_peaks( X, display_peaks_flag, title_str, x_label_str, y_label_str, path, filename)
%PLOT_DATA_AND_PEAKS Summary of this function goes here
%   Detailed explanation goes here

figure;
plot(X)

if display_peaks_flag == 1
    [Peak, PeakIdx] = findpeaks(X);
    text( X(PeakIdx), Peak, sprintf('Peak = %6.3f', Peak) )
end

title(title_str)
ylabel(x_label_str)
xlabel(y_label_str)

save_png(path, filename);

end

