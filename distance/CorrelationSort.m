function AtribList = CorrelationSort(dataset,selector_type)
    nAtrib = size(dataset,2);
    AtribInd = (1:nAtrib)';
    AtribList = zeros(nAtrib,1);
    Correlation_Matrix = calcCorrelationMatrix(dataset,selector_type);
    Correlation_Matrix2 = Correlation_Matrix;
    for i = 1:nAtrib
        % select the two atributes with maximum correlation between them
        [~,ind] = max(Correlation_Matrix(:));
        Atrib1 = mod(ind-1,nAtrib)+1; 
        Atrib2 = (ind - Atrib1)/nAtrib+1;
        % sort correlations with respect the two selected atributes
        v1 = sort(Correlation_Matrix(:,Atrib1));
        v2 = sort(Correlation_Matrix(:,Atrib2));
        if v1(end) <= v2(end) 
            dataset(:,Atrib1) = [];
            Correlation_Matrix(:,Atrib1) = [];
            Correlation_Matrix(Atrib1,:) = [];
            AtribList(i) = AtribInd(Atrib1);
            AtribInd(Atrib1) = [];
            nAtrib = nAtrib - 1;
        else
                dataset(:,Atrib2) = [];
                Correlation_Matrix(:,Atrib2) = [];
                Correlation_Matrix(Atrib2,:) = [];
                nAtrib = nAtrib - 1;
        end
    end
    figure   
    mesh(Correlation_Matrix2(AtribList,AtribList))
    colorbar
    
end