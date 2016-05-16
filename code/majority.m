function [ out ] = majority( in )
%MAJORITY Summary of this function goes here
%   Detailed explanation goes here

    %Find the array index corresponding to  the value with the most occurrences
    [count, values] = hist(in, unique(in));    
    [Vmax, argmax] = max(count);
    out = values(argmax);

end
%EOF