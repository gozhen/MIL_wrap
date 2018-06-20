function range = f_instNo_range(instNo, l, k, s)
%
% l: sequence length
% k: k_out model length, AKA, instance length
% s: shift range

n_insts = ceil((l-k)/s) + 1;
% instNo, n_insts,
if instNo <= n_insts
    startp = (instNo-1)*s+1;
    endp = startp+ k - 1;
    if endp> l
        dif = endp - l;
        
        endp = l;
        startp = startp-dif;
    end
else
    fprintf('error, instance number > total number of instances\n');
end

range = [startp, endp];

end

