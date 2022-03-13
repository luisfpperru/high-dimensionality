function X = shuffle(X,dim)
    if dim == 1
        N = size(X,1);
        order = randperm(N);
        X = X(order,:); 
    end
    if dim == 2
        N = size(X,2);
        order = randperm(N);
        X = X(:,order);
    end
end