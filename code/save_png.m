function save_png( path, filename, handle )
%SAVE_PNG Summary of this function goes here
%   Detailed explanation goes here

global UI_MODE
global SAVE_FIG_FLAG

if nargin < 3
   handle = gcf;
end

if SAVE_FIG_FLAG

    filepath = sprintf('%s/%s.png', char(path), char(filename));

    if ~exist(path, 'dir')
      mkdir(path);
    end

    saveas(handle, filepath)

end

if ~UI_MODE
    close(handle);
end

end
