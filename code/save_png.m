function save_png( path, filename, handle )
%SAVE_PNG Saves the figure passed as a handle at the specified path, with
% the specified filename. The file handle is optional, and if it is missing
% the current figure handle will be used instead.

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
