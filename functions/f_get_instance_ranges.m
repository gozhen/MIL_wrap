function r = f_get_instance_ranges(l,k,s)
% Revised from python function: f_get_instance_posi() in utili.py
%
% Compute the instance ranges of the instances.
%  For example, we have a 35mer, we want to let the kmer's length to be 18,
%  and the range (span, or, shift) between the closest instances to be 9 
%  (instead of 1 that we previously did), we just want to a function to 
%  compute the start point and end point of each instance.

i=1;
r=[];
while i<=l
    if i+k <= l
        tmp=[i, i+k-1];
        r=[r; tmp];
        i=i+s;
    else
        tmp=[i, l];
        r=[r; tmp];
        i=l+s;
    end
    
end

% if the last instance is shorter than k-1, then make it to be k-1
%  for example: r = f_get_instance_ranges(35, 30, 30)
% r =
%      1    30
%     31    35
%  which is not good. 

if r(end, 2) - r(end, 1) < (k-1)
    r(end, 2) = l;
    r(end, 1) = l - (k-1);
    if r(end, 1) <= 0
        r(end, 1) = 1;
    end
end

end

