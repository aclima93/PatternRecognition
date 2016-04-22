function save_png( path, filename )
%SAVE_PNG Summary of this function goes here
%   Detailed explanation goes here

SAVE_FIG = 0;

if SAVE_FIG

    filepath = sprintf('%s/%s.png', char(path), char(filename));

    if ~exist(path, 'dir')
      mkdir(path);
    end

    saveas(gcf, filepath)

end

end

