function dist = MetricHistogram(x,y)
    x = x(:);
    y = y(:);
    dim = size(x,1);
    alfa = zeros(dim-1,1);
    alfa2 = zeros(dim-1,1);
    beta = zeros(dim-1,1);
    beta2 = zeros(dim-1,1);
    dist = 0;
    for i = 1:dim-1
        c = [1 i; 1 i+1]\[x(i);x(i+1)];
        alfa(i) = c(1);
        beta(i) = c(2);
        area = alfa(i)+beta(i)*(2*i+1);
        c = [1 i; 1 i+1]\[y(i);y(i+1)];
        alfa2(i) = c(1);
        beta2(i) = c(2);
        area2 = alfa2(i)+beta2(i)*(2*i+1);
        dist = dist + abs(area - area2);
    end
end