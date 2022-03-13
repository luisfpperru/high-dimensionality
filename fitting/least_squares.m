function least_squares(filename,distance_type,reduction_method,D_exp,ind,D)
    close all

    nbuckets = 128;
    D_exp = D_exp(:);
    D = D(:);
    ind = ind(:);
    n = size(D_exp,1);  
    nuisance_exp = zeros(n,1);
    nuisance_exp2 = zeros(n,1);
    nuisance_exp3 = zeros(n,1);
    dist_mean = zeros(n,1);
    dist_std = zeros(n,1);
    dist_mean_more_std = zeros(n,1);
    dist_mean_less_std = zeros(n,1);
    figure
    for i = 1:n
        data = load(['Bedo-Perru/plots/',reduction_method,'/histograms/',filename,'/',filename,'_',num2str(D_exp(i)),'atributes_',distance_type,'.txt']);
        buckets = data(:,1);
        histo = data(:,2);
        histo_norm = histo/sum(histo); % histogram normalized with respect to the area
        dist_mean(i) = sum(histo_norm.*buckets);
        square_dist_mean = sum(histo_norm.*buckets.^2);
        dist_std(i) = sqrt(square_dist_mean - dist_mean(i)^2);
        gaussian = exp(-(buckets - dist_mean(i)).^2/(2*dist_std(i)^2));
        nuisance_exp(i) = exp(- dist_std(i)/dist_mean(i));
        nuisance_exp2(i) = exp(- dist_std(i)^2/dist_mean(i));
        nuisance_exp3(i) = exp(- dist_std(i)/dist_mean(i)^2);
        dist_mean_more_std(i) = dist_mean(i) + dist_std(i);
        dist_mean_less_std(i) = dist_mean(i) - dist_std(i);
        w = sqrt(sum((histo - gaussian).^2)/nbuckets);
        if log2(i) == round(log2(i))
            subplot(ceil(log2(n)/3),3,log2(i)+1)
            plot(buckets,[histo,gaussian])
        end
    end
    disp(filename)
%     disp(D_exp(dist_mean == 0 & dist_std == 0))
    D_tilde = D_exp(ind);
    nuisance = nuisance_exp(ind);
    nuisance2 = nuisance_exp2(ind);
  
%     delta = 10^(-3);
    A = [D_tilde.^0,D_tilde];
    b = nuisance;
    c = pinv(A'*A)*(A'*b);
    lin = A*c;
    A = [D.^0,D];
    linear = A*c;
    
    A = [D_tilde.^0,D_tilde];
    b = nuisance2;
    c = pinv(A'*A)*(A'*b);
    lin2 = A*c;
    A = [D.^0,D];
    linear2 = A*c;
    
%     [sigmoide_bar,c] = logistic_regression(log(D_tilde),nuisance,log(D));
%     sigmoide_tilde = sigmoide(log(D_tilde),c);   
%     [overx,c_overx]=assind3(D_tilde,nuisance,D);
%     limit = c_overx(1);
%     limit = max(nuisance)+delta; 
    limit = lin(end);
    [sigmoide_lin,c] = logistic_regression(log(D_tilde),nuisance/limit,log(D));
    sigmoide_lin = limit*sigmoide_lin;
%     disp(c_overx(1)+2*c_overx(2))
     [overx,c_overx]=assind3(sqrt(D_tilde),nuisance,sqrt(D));
     limit = c_overx(1);
     [sigmoide_overx,cc] = logistic_regression(log(D_tilde),nuisance/limit,log(D));
     sigmoide_overx = limit*sigmoide_overx;
     slope = 1/2*(nuisance(3:end) - nuisance(1:end-2));
     der_slope = (nuisance(3:end) - 2*nuisance(2:end-1) + nuisance(1:end-2));
     slope_lin = 1/2*(sigmoide_lin(3:end) - sigmoide_lin(1:end-2));
     der_slope_lin = (sigmoide_lin(3:end) - 2*sigmoide_lin(2:end-1) + sigmoide_lin(1:end-2));
%   
%     [sigmoide_bar2,c2] = logistic_regression(log(D_tilde),nuisance2,log(D));
%     sigmoide_tilde2 = sigmoide(log(D_tilde),c2);
%     [overx2,c_overx2]=assind3(D_tilde,nuisance2,D);
%     limit2 = c_overx2(1);
%     limit2 = max(nuisance2)+delta; 
     limit2 = lin2(end);
     [sigmoide_lin2,c2] = logistic_regression(log(D_tilde),nuisance2/limit2,log(D));
     sigmoide_lin2 = limit2*sigmoide_lin2;
     [overx2,c_overx2]=assind3(sqrt(D_tilde),nuisance2,sqrt(D));
     limit2 = c_overx2(1); 
     [sigmoide_overx2,cc2] = logistic_regression(log(D_tilde),nuisance2/limit2,log(D));
     sigmoide_overx2 = limit2*sigmoide_overx2;
     slope2 = 1/2*(nuisance2(3:end) - nuisance2(1:end-2));
     der_slope2 = (nuisance2(3:end) - 2*nuisance2(2:end-1) + nuisance2(1:end-2));
     slope_lin2 = 1/2*(sigmoide_lin2(3:end) - sigmoide_lin2(1:end-2));
     der_slope_lin2 = (sigmoide_lin2(3:end) - 2*sigmoide_lin2(2:end-1) + sigmoide_lin2(1:end-2));
     
%      IC = (0.05:0.01:0.5).';
%  IC = (0.5:0.01:0.99).';
%      p0 = 1/(1+exp(-(c(2)*log(1)+c(1))));
%      D_star = round(exp((log((1 - IC*(1 - p0))./(IC*(1 - p0)))  - c(1))/c(2)));
%      D_star = round(exp((log((IC*(1 - p0)+ p0)./((1 - IC)*(1 - p0)))  - c(1))/c(2)));
     epsilon = (0.01:0.01:1)';
     alfa = c(2);
     beta = c(1);
     disp([alfa,beta])
     f_infty = log(1 + exp(alfa*log(D(end))+beta));
     f1 = log(1 + exp(alfa*log(1)+beta));
     fx = (1 - epsilon)*f_infty + epsilon*f1;
     D_star = exp( (log( exp(fx) -1 ) - beta )/alfa)+log(max(D));
     area = log(1+exp(alfa*log(D/max(D))+beta));
     aux1 = - dilog(-exp(alfa*log(D)+beta))/alfa;
     aux2 = - dilog(-exp(beta))/alfa;
     aux3 = - dilog(-exp(alfa*log(max(D))+beta))/alfa;
     area2 = (aux1 - aux2)/(aux3 - aux2);
     
%      disp(D_star)
     
%      fprintf('\n %f - %f \n',D_star,log2(D_star))
     
%      p02 = 1/(1+exp(-(c2(2)*log(1)+c2(1))));
%      D_star2 = round(exp(log((1 - IC*(1 - p02))/(IC*(1 - p02))  - c2(1) )/c2(2)));
%      fprintf('\n %f - %f \n',D_star2,log2(D_star2))


%      p = 100;
%      n = size(D,1);
%      linear = zeros(n,floor(n-2/p));
%      linear2 = zeros(n,floor(n-2/p));
%      for i = 2:p:n-2
%         linear(:,i) = slope_lin(i)*(D - D(i))+ sigmoide_lin(i);
%         linear2(:,i) = slope_lin2(i)*(D - D(i))+ sigmoide_lin2(i);
%      end

%     disp(c_overx2(1)+2*c_overx2(2))
    
%     minimo = sigmoide(log2(1),c);
%     minimo2 = sigmoide(log2(1),c2);

%     close all
    
%     figure
%     subplot(1,2,1)
%     plot(log2(D_tilde),nuisance,'b',log2(D),sigmoide_bar,'k--',log2(D),sigmoide_overx,'r--',log2(D),overx,'g--',log2(D),ones(size(D,1),1).*limit,'b--')
%     legend('Nuisance (sigma/mi)','Sigmoide','Sigmoide OverX normalized','OverX',4)
%     axis([1,max(log2(D)),minimo,1])
%     xlabel('Log2(Dimensionality)')
%     ylabel('Nuisance Function')
%     title([reduction_method,' reduction of dataset ',filename,' with ',distance_type,' distance function'])
%     
%     subplot(1,2,2)
%     plot(log2(D_tilde),nuisance2,'b',log2(D),sigmoide_bar2,'k--',log2(D),sigmoide_overx2,'r--',log2(D),overx2,'g--',log2(D),ones(size(D,1),1).*limit2,'b--')
%     legend('Nuisance (sigma^2/mi)','Sigmoide (sigma^2/mi)','Sigmoide OverX normalized','OverX',4)    
%     axis([1,max(log2(D)),minimo2,1])
%     xlabel('Log2(Dimensionality)')
%     ylabel('Nuisance Function')
%     title([reduction_method,' reduction of dataset ',filename,' with ',distance_type,' distance function'])

   figure 
   plot(D_exp,dist_mean,'r',D_exp,dist_mean_more_std,'k',D_exp,dist_mean_less_std,'k')
   xlabel('Dimensionality')
   legend('mi','mi+-sigma',4)
   
%    figure
%    plot(D_exp,w,'b')
%    legend('gaussian approximation error')
%    
    figure
    hold on
    plot(D_tilde,nuisance,'k.','MarkerSize',4,'Color',[0.5,0.5,0.5])
    plot(D,sigmoide_overx,'k')
    legend('Nuisance (sigma/mi)','Sigmoide',4)
    axis([1,max(D_tilde),min(nuisance),1])
    xlabel('Dimensionality')
    ylabel('Nuisance Function')
    hold off

    
    saveas(gcf,['Bedo-Perru/',filename,'_',reduction_method,'_fits.pdf'])

    
    
%     [max_slope,ind] = max(der_slope);
%     disp(D_tilde(ind+1))
%     [max_slope2,ind2] = max(der_slope2);
%     disp(D_tilde(ind2+1))

    figure
    
    subplot(2,2,1)
    loglog(D_tilde(2:end-1),abs(slope),'b ',D(2:end-1),abs(slope_lin),'k')
    title('Nuisance (sigma/mi) Slope')
    legend('Medi��es','Modelo aproximado')
    subplot(2,2,2)
    loglog(D_tilde(2:end-1),abs(der_slope),'b ',D(2:end-1),abs(der_slope_lin),'k')
    title('Nuisance (sigma/mi) Derivative Slope')
    legend('Medi��es','Modelo aproximado')
    subplot(2,2,3)
    loglog(D_tilde(2:end-1),abs(slope2),'b ',D(2:end-1),abs(slope_lin2),'k')
    title('Nuisance (sigma^2/mi) Slope')
    legend('Medi��es','Modelo aproximado')
    subplot(2,2,4)
    loglog(D_tilde(2:end-1),abs(der_slope2),'b ',D(2:end-1),abs(der_slope_lin2),'k')
    title('Nuisance (sigma^2/mi) Derivative Slope')
    legend('Medi��es','Modelo aproximado')
    
    figure
    plot(epsilon,D_star/max(D_star),'b')
    ylabel('Dimensionality')
    xlabel('Confidence Interval')
    
%     figure
%     plot(nuisance,D_tilde,'b',sigmoide_overx,D,'g--')
%     legend('Nuisance (sigma/mi)','Sigmoide Linear',4)
%     axis([min(nuisance),1,1,max(D_tilde)])
%     ylabel('Dimensionality')
%     xlabel('Concentration Function')
%     
    figure
    plot(D/max(D),area,'b--')
    
    figure
    plot(D,area2,'b--')
    
    nbuckets = 128;
    buckets = linspace(0,1,nbuckets).';
    histo = zeros(nbuckets,1);
    acum_histo = zeros(nbuckets,1);
    for j = 1:size(area,1)
        for i  = 1:nbuckets-1
            if buckets(i) <= (area(j)/max(area)) && (area(j)/max(area)) < buckets(i+1)
                histo(i) = histo(i) + 1;
            end
        end
    end
    acum_histo(1) = histo(1);
    for i = 2:nbuckets
        acum_histo(i) = acum_histo(i-1) + histo(i);
    end
    histo = histo/max(histo);
    acum_histo = acum_histo/max(acum_histo);
    IC = 0.010; % confince interval
    d = buckets*max(D);
    [~,ind] = min(abs(IC-acum_histo));
    cd = floor(d(ind)); % concentration dimension
    figure
    plot(d,histo,'b')
    figure
    plot(d,acum_histo,'r')
    grid on
    [~,ind] = min(abs(0.1-acum_histo));
    d2 = floor(d(ind)); %   
    saveas(gcf,['Bedo-Perru/',filename,'_',reduction_method,'_area_histogram.pdf'])
    figure
    plot(buckets*max(D),acum_histo,'r')
    grid on
    axis([0,d2,0,0.1])
    saveas(gcf,['Bedo-Perru/',filename,'_',reduction_method,'_area_histogram_zoom.pdf'])
    
    disp(cd);
    
    
    
    
%     figure
%     plot(D,log(sigmoide_overx./(1 - sigmoide_overx)),'r',D_tilde,log(nuisance./(1 - nuisance)),'b')
%     
   
%      A = [D_tilde.^0,D_tilde,nuisance,D_tilde.*nuisance];
%      b = 0*nuisance;
%      c = pinv(A'*A)*(A'*b);
%      nuisance_bar = (-c(2)/c(4))./(1 - 1./(c(3)-1+c(4)*D));
%      
%      figure
%      plot(D_tilde,nuisance,'b',D,nuisance_bar,'k--')
%      legend('Nuisance (sigma^2/mi)','New model',4)
%      xlabel('Dimensionality')
%      ylabel('Nuisance Function')
%     
%     mean_square_error = sqrt(sum((sigmoide_tilde - nuisance).^2)/n);
%     max_square_error = sqrt(max((sigmoide_tilde - nuisance).^2));
%     mean_square_error2 = sqrt(sum((sigmoide_tilde2 - nuisance2).^2)/n);
%     max_square_error2 = sqrt(max((sigmoide_tilde2 - nuisance2).^2));
%     fprintf('\n Sigmoide (sigma/mi) mean: %f , max: %f \n Sigmoide (sigma^2/mi) mean: %f , max %f \n',mean_square_error,max_square_error,mean_square_error2,max_square_error2)

%     status = 1;
%     if ~exist(['Bedo-Perru/plots/',reduction_method,'/fits/',filename], 'dir') %  check if folder exists
%       status = mkdir(['Bedo-Perru/plots/',reduction_method,'/fits/',filename]); % case not, attempt to create the folder
%     end
%     if status == 1
%       data1 = [D_exp,nuisance_exp,nuisance_exp2,dist_mean,dist_std,dist_mean_more_std,dist_mean_less_std];
%       data2 = [D,sigmoide_bar,sigmoide_bar2,[mean_square_error;max_square_error;mean_square_error2;max_square_error2;NaN*ones(size(D,1)-4,1)]];
%       save(['Bedo-Perru/plots/',reduction_method,'/fits/',filename,'/measures_',filename,'_',distance_type,'.txt'],'data1','-ascii','-double');
%       save(['Bedo-Perru/plots/',reduction_method,'/fits/',filename,'/model_',filename,'_',distance_type,'.txt'],'data2','-ascii','-double');
%     end
end