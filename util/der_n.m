%% Programa que calcula a derivada enesima de uma funcao de derivada polinomial
function  y = der_n(x,v0,n)
    x = x(:);
    v0 = v0(:);
    v = v0;
    for i = 2:n
        dc = der_coef(v);
        v = prod_coef(dc,v0);
    end
    y = calc_deriv(v,x);
end
function dy_dx  = calc_deriv(v,x)
    n = size(v,1);
    y = zeros(size(x,1),n);
    for i = 1:n
        y(:,i) = x.^(i-1);
    end
    dy_dx = y*v;
end
function coef = der_coef(v)
    n = size(v,1);
    coef = (1:n-1)'.*v(2:n);
end
function produto  = prod_coef(v1,v2)
    n1 = size(v1,1);
    n2 = size(v2,1);
    produto = zeros((n1-1)+(n2-1)+1,1);
   for i = 1:n1
       for j = 1:n2 
               produto((i-1)+(j-1)+1) = produto((i-1)+(j-1)+1) + v1(i)*v2(j);
       end
   end 
end