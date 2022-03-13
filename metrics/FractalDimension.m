function FractalDimension(classes,acum_histo)
    n = size(classes,1);
    n2 = size(acum_histo);
    if n ~= n2
        print('Erro! vetores de dimensões diferentes')
        exit
    end
     A = [ones(n,1),log2(classes)];
     b = log2(acum_histo);
     c = pinv(A'*A)*(A'*b);
     D = ceil(c(2));
     disp(D)
     figure
%      loglog(classes,acum_histo)
     plot(log2(classes),log2(acum_histo),'b',log2(classes),A*c,'r');
end