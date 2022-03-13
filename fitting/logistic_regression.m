function [p_bar,c] = logistic_regression(x,p,X)
    x = x(:);
    p = p(:);
    A = [ones(size(x,1),1),x];
    b = log(p./(1 - p));
    c = pinv(A'*A)*A'*b;
    A2 = [ones(size(X,1),1),X];
    p_bar = 1./(1+exp(-A2*c));
end