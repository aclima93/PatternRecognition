function save_png( path, filename )
%SAVE_PNG Summary of this function goes here
%   Detailed explanation goes here

filepath = sprintf('%s/%s.png', char(path), char(filename));

if mkdir(path)
    saveas(gcf, filepath)
end

end

