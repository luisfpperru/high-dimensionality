function Correlation_Matrix = FeatureSelector(x,y,selector_type)
    if strcmp(selector_type,'Pearson')
        Correlation_Matrix = Pearson(x,y);        
    else
        error('Error at FeatureSelector function. Feature selector type unknown') % error case
    end
end