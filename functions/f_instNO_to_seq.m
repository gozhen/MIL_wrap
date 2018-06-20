function seq = f_instNO_to_seq(whole_seq, instNo, l, k, s)
% input the instance id and return the sequence.
range = f_instNo_range(instNo, l, k, s);
% range(1), range(2),
seq = whole_seq(range(1) : range(2) );

end

