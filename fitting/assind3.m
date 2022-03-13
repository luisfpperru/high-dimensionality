function [Fx,c] = assind3(x,y,X)
    x = x(:);
    y = y(:);
    n = size(y,1); %  Numero de pontos
    
    % Resolu��o do Sistema Linear de Equacoes Normais - Minimos Quadrados 
    
%     A = [ones(n,1) x x.^2]'*[x y ones(n,1)];
%     b = [ones(n,1) x x.^2]'*(x.*y);
%     c = A\b;
%     
    A = [x y ones(n,1)];
    b = x.*y;
    c = pinv(A'*A)*(A'*b);   % Calculo dos coeficientes
%     c = (A'*A)\(A'*b);   % Calculo dos coeficientes
    Fx = c(1) + (c(3) + c(1)*c(2))./(X - c(2)); %  Calculo da funcao estimada nos pontos considerados

   
end