function performance = datasetClassify(dataset,k)
    
    k = k(:);
    variables = dataset(:,1:end-1);
    labels = dataset(:,end);
    nclasses = max(labels);
    n_instances = size(variables,1);
    response = zeros(n_instances,1);
    performance = zeros(size(k,1),1);
    for i = 1:size(k,1)
        NN = knnsearch(dataset,dataset,'K',i);
        for instance = 1:n_instances
            NeighborsClasses = zeros(nclasses,1);
            for class = 1:nclasses
                NeighborsClasses(class) = sum(labels(NN(instance,:)') == class);
            end
             [~,ind] = max(NeighborsClasses);
             response(instance) = ind;
        end
        performance(i) = mean(fmeasure(response,labels));
    end
    
end