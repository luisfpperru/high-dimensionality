function f_measure = fmeasure(response,labels)
    nclasses = max(labels);
    f_measure  = zeros(nclasses,1);
    for class = 1:nclasses
        tp=sum(labels == class & response == labels);    % true positives
        fp=sum(labels ~= class & response == labels);    % false positives
        fn=sum(labels == class & response ~= labels);    % false negatives
        precision=tp/(tp+fp); 
        recall = tp/(tp+fn);
        f_measure(class) = 2*(precision*recall)/(precision+recall);
    end
end