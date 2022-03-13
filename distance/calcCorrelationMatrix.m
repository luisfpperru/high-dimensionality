function Correlation_Matrix = calcCorrelationMatrix(dataset,selector_type)
    nAtrib = size(dataset,2);
    Correlation_Matrix = zeros(nAtrib,nAtrib); 
    for i = 1:nAtrib
       for j = 1:i-1
             Correlation_Matrix(i,j) = abs(FeatureSelector(dataset(:,i),dataset(:,j),selector_type)); 
             Correlation_Matrix(j,i) = Correlation_Matrix(i,j);
       end
    end
end