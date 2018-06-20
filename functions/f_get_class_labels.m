function labels = f_get_class_labels(charLabels)
% convert the class labels from 'p' and 'n' to real value labels.

len = length(charLabels);
labels = zeros(len, 1);
for i=1:len
    if strcmp(charLabels(i), 'p')
        labels(i)=1;
    end
end

end

