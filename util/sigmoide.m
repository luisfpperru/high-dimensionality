function p = sigmoide(x,c)
    p = 1./(1+exp(-[x.^0,x]*c));
end