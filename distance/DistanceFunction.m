function dist = DistanceFunction(x,y,distance_type)
    x = x(:);
    y = y(:);
    if strcmp(distance_type,'Euclidean')
        dist = sqrt(sum((x - y).^2)); % norma L2
    elseif strcmp(distance_type,'Manhattan')
         dist = sum(abs(x - y)); % norma L1
    
    elseif strcmp(distance_type,'Chebyshev')
         dist = max(abs(x - y)); % norma L infinito
    elseif strcmp(distance_type,'Canberra')
        Numerator = abs(x - y);
        Denominator = abs(x)+abs(y);
        dist = sum(Numerator(Denominator ~= 0)./Denominator(Denominator ~= 0)); 
    elseif strcmp(distance_type,'Bray-Curtis')
        Numerator = abs(x - y);
        Denominator = x+y;
        dist = sum(Numerator(Denominator ~= 0)./Denominator(Denominator ~= 0)); 
    elseif strcmp(distance_type,'Metric-Histogram')
        dist = MetricHistogram(x,y); 
    elseif ( length(distance_type) > length('Fractional-') ) && ( strcmp(distance_type(1:length('Fractional-')),'Fractional-') )
        p = str2double(distance_type(length('Fractional-')+1:end));
        dist = sum((abs(x - y)).^p)^(1/p); % norma Lp
    elseif strcmp(distance_type,'Cosine')
	Numerator = abs(sum(x.*y));
	Denominator = (sqrt(sum(x.^2))*sqrt(sum(y.^2)));
        if Denominator ~= 0
		dist = Numerator/Denominator; % Cosine similarity
	else 
		dist = 0;
	end
    else
         error('Error at DistanceFunction function. Distance function type unknown') % error case
    end 
end
