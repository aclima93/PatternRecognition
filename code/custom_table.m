function [ output_args ] = custom_table( d, cnames, rnames )
%CUSTOM_TABLE Summary of this function goes here
%   Detailed explanation goes here

f = figure;
t = uitable(f,'Data',d,'ColumnName',cnames,'RowName',rnames);
% Set width and height
t.Position(3) = t.Extent(3);
t.Position(4) = t.Extent(4);

end
%EOF