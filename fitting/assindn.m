function [Fx,c] = assindn(x,y,X)
    x = x(:);
    y = y(:);
    n = size(y,1); %  Numero de pontos
    A = [ones(n,1),x,x.^2,y,x.*y];
    b = x.^2.*y;
    c = pinv(A'*A)*(A'*b);
    Fx = c(3) +(c(1)+c(3)*c(4))./(X.^2-c(4)-c(5)*X);
end