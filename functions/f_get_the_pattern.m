function [ pattern ] = f_get_the_pattern(digit)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if digit == 1;
    pattern = ['A';'C';'G';'T'];
else 
    sub_p = f_get_the_pattern(digit-1);
    len = 4^(digit-1);
    pattern = [repmat('A',len,1),sub_p;
               repmat('C',len,1),sub_p;
               repmat('G',len,1),sub_p;
               repmat('T',len,1),sub_p];
end
end

