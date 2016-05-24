function [ sub_folders ] = subdirectories( dir_path )
%SUBDIRECTORIES 
% Get a list of all files and folders in this folder.
% Get a logical vector that tells which is a directory.
% Extract only those that are directories & delete the current (.) and
% parent (..) references.

files = dir(dir_path);
dir_flags = [files.isdir];
sub_folders = files(dir_flags);
sub_folders(1:2) = [];

end

