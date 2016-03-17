function [  ] = custom_pie_chart( values, labels )
%CUSTOM_PIE_CHART Summary of this function goes here
%   Detailed explanation goes here

figure
h = pie(values);

hText = findobj(h,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values

combinedstrings = strcat(labels, percentValues'); % strings and percent values

oldExtents_cell = get(hText,'Extent'); % cell array
oldExtents = cell2mat(oldExtents_cell); % numeric array

hText(1).String = combinedstrings(1);
hText(2).String = combinedstrings(2);
hText(3).String = combinedstrings(3);

newExtents_cell = get(hText,'Extent'); % cell array
newExtents = cell2mat(newExtents_cell); % numeric array
width_change = newExtents(:,3)-oldExtents(:,3);

signValues = sign(oldExtents(:,1));
offset = signValues.*(width_change/2);

textPositions_cell = get(hText,{'Position'}); % cell array
textPositions = cell2mat(textPositions_cell); % numeric array
textPositions(:,1) = textPositions(:,1) + offset; % add offset

hText(1).Position = textPositions(1,:);
hText(2).Position = textPositions(2,:);
hText(3).Position = textPositions(3,:);

end
%EOF
