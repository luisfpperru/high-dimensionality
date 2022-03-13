function [Fx,c] = assind2(x,y,X)
    x = x(:);
    y = y(:);
    n = size(y,1); %  N�mero de pontos
    
    % Resolu��o do Sistema Linear de Equações Normais - Minimos Quadrados 
    
%     A = [ones(n,1) x x.^2]'*[x y ones(n,1)];
%     b = [ones(n,1) x x.^2]'*(x.*y);
%     c = A\b;
    
    A = [ones(n,1),(y-1)];
    b = x.*(y-1);
    c = pinv(A'*A)*(A'*b);   % Calculo dos coeficientes
    Fx = 1 + c(1)./(X - c(2)); %  Calculo da função estimada nos pontos considerados
end
