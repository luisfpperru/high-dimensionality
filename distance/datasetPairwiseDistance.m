function datasetPairwiseDistance(dataset,file_name,distance_type,reduction_method)

    N = size(dataset,1); % dimensao do problema em que N eh o numero de pontos
    nAtrib = size(dataset,2);
    nbuckets = 128; % numero de buckets
    
    %% calcula histograma via matriz de distancias
    
%     dist = zeros(N^2,1);
%     histo = zeros(nbuckets,1);
%     acum_histo = zeros(nbuckets,1);
%     acum_gaussian = zeros(nbuckets,1);
%     
%     fprintf('Calculating pairwise distances for %d atributes...Progress  ',nAtrib)
%     histo(1) = N;
%     size_string = 0;
%     tic
%     for i = 1:N
%         for j = 1:i-1
%                 dist((i-1)*N+j) = DistanceFunction(dataset(i,:),dataset(j,:),distance_type); 
%                 dist((j-1)*N+i) = dist((i-1)*N+j);
%                 if toc > 1
%                                fprintf(repmat('\b',[1,size_string]));
%                                num = [num2str(100*(( (i-2)*(i-1)/2+j)/(N*(N-1)/2) )),'%'];
%                                fprintf('%s',num);
%                                size_string = length(num);
%                                tic
%                 end
%         end
%     end
%     DMAX = max(dist);
%     dist = dist/DMAX;
%     dist_medio = mean(dist);
%     dist_desvio = std(dist);
    
     % construcao do histograma 
     
%     fprintf('Building histogram for %d atributes...Progress  ',nAtrib)
%     size_string = 0;
%     tic
%     for i = 1:N
%         for j = 1:i-1
%             for k = 1:nbuckets
%                  if dist((i-1)*N+j) >= (k-1)/nbuckets &&  dist((i-1)*N+j) < k/nbuckets 
%                         histo(k) =  histo(k) + 2; % valores de frequencia do histograma
%                          if toc > 1
%                                fprintf(repmat('\b',[1,size_string]));
%                                num = [num2str(100*(( (i-2)*(i-1)/2+j)/(N*(N-1)/2) )),'%'];
%                                fprintf('%s',num);
%                                size_string = length(num);
%                                tic
%                          end
%                  end  
%             end
%         end
%     end  
    
    %% calcula histograma diretamente sem construcao da matriz de distancias
    
    %% calcula DMAX 
    

   
        tic 
        fprintf('Calculating DMAX for %d atributes...Progress  ',nAtrib)
        DMAX = 0;
        size_string = 0;
        
        tic
        for i = 1:N
            for j = 1:i-1
                dist = DistanceFunction(dataset(i,:),dataset(j,:),distance_type);
                if dist > DMAX
                    DMAX = dist;
                end
                if toc > 1
                    fprintf(repmat('\b',[1,size_string]));
                    num = [num2str(100*(( (i-2)*(i-1)/2+j)/(N*(N-1)/2) )),'%'];
                    fprintf('%s',num);
                    size_string = length(num);
                    tic
                end
            end
        end   
        fprintf(repmat('\b',[1,size_string]));
        num = [num2str(100),'%'];
        fprintf('%s\n',num);

    %% construcao do histograma 
    
        fprintf('Building histogram for %d atributes...Progress ',nAtrib)     
        classes = linspace(0,1,nbuckets).';
        histo = zeros(nbuckets,1);
        histo(1) = N;

        sum_dist = 0;
        sum_square_dist = 0;
        size_string = 0;
        tic
        for i = 1:N
            for j = 1:i-1
                dist = DistanceFunction(dataset(i,:),dataset(j,:),distance_type)/DMAX;
                
                sum_dist = sum_dist + 2*dist;
                sum_square_dist = sum_square_dist + 2*dist^2;
            
%                 %  busca sequencial
%                pare = 0;
%                k = 1;
%                while k <= nbuckets && pare == 0
%                   if  dist >= (k-1)/nbuckets && dist < k/nbuckets
%                         histo(k) =  histo(k) + 2; % incrementa valores de frequencia do histograma
%                         pare = 1;
%                   else
%                         k = k+1;
%                   end
%                end
%                if toc > 1
%                         fprintf(repmat('\b',[1,size_string]));
%                         num = [num2str(100*(( (i-2)*(i-1)/2+j)/(N*(N-1)/2) )),'%'];
%                         fprintf('%s',num);
%                         size_string = length(num);
% %                     data = [classes,histo,acum_histo,gaussian,acum_gaussian,[DMAX;NaN;i;j;NaN*ones(nbuckets-4,1)]];
% %                     save(['results/',file_name,'/data/',distance_type,'/histo_',num2str(nbuckets),'buckets_from_',file_name,'_',num2str(nAtrib),'atributes_',distance_type,'.txt'],'data','-ascii','-double');
%                         tic
%                 end
                

                % busca binaria
                a = 0;
                b = nbuckets;
                while abs(b - a) > 1
                    k = round((a+b)/2);
                    if  dist >= classes(k+1)
                        a = k;
                    else
                        b = k;
                    end  
                end
                histo(b) =  histo(b) + 2; % incrementa valores de frequencia do histograma   
                if toc > 1
                    fprintf(repmat('\b',[1,size_string]));
                    num = [num2str(100*(( (i-2)*(i-1)/2+j)/(N*(N-1)/2) )),'%'];
                    fprintf('%s',num);
                    size_string = length(num);
%                     data = [classes,histo,acum_histo,gaussian,acum_gaussian,[DMAX;NaN;i;j;NaN*ones(nbuckets-4,1)]];
%                     save(['results/',file_name,'/data/',distance_type,'/histo_',num2str(nbuckets),'buckets_from_',file_name,'_',num2str(nAtrib),'atributes_',distance_type,'.txt'],'data','-ascii','-double');
                        tic
                end
           end
        end
        fprintf(repmat('\b',[1,size_string]));
        num = [num2str(100),'%'];
        fprintf('%s\n',num);
        HMAX = max(histo);
        
         % Calculo da media, desvio e gaussiana aproximada pelos valores da distancia
    
            dist_medio = sum_dist/N^2;
            square_dist_medio = sum_square_dist/N^2;
            dist_desvio = sqrt(square_dist_medio - dist_medio^2);
            histo = histo/max(histo);
            classes = linspace(0,1,nbuckets).';
            gaussian = exp(-((classes - dist_medio).^2/(2*dist_desvio^2)));
    
        %% Calculo da media, desvio e gaussiana aproximada pelas frequencias do histograma

%         histo = histo/sum(histo);
%         dist_medio = sum(histo.*classes);
%         square_dist_medio = sum(histo.*classes.^2);
%         dist_desvio = sqrt(square_dist_medio - dist_medio^2);
%         histo = histo/max(histo);
%         gaussian = exp(-((classes - dist_medio).^2/(2*dist_desvio^2)));
        
    fprintf('Saving...\n')
    status = 1;
    if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
        status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
    end
    if status == 1
        data = [classes,histo,gaussian,[DMAX;HMAX;NaN*ones(nbuckets-2,1)]];
        save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/',file_name,'_',num2str(nAtrib),'atributes_',distance_type,'.txt'],'data','-ascii','-double');        
    end
    
    %% Plotando  
   
%         fprintf('Plotting...\n')
%         figure
%         plot(classes,histo,'k',classes,gaussian,'b--')
%         legend('histogram','gaussian aproximation',1)
%         ylabel('Frequency')
%         xlabel('Normalized Pairwise Distance')
%         title(['Histogram for ',num2str(nbuckets),' buckets from ',file_name,' - number of atributes = ',num2str(nAtrib),' - ',distance_type])
end
