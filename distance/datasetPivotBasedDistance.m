function datasetPivotBasedDistance(dados,file_name)
    N = size(dados,1); % dimensão do problema em que N é o número de pontos
    dim = size(dados,2);
    nbuckets = 128; % número de buckets
    npivos = dim; % obter número de pivos
    [kind,pivos] = kmeans(dados,npivos); % obter pivos
   
    % calcula distancias
    dist_pivo = zeros(N,1);
    for i = 1:N
        dist_pivo(i) = sqrt(sum( ( pivos(kind(i),:) - dados(i,:) ).^2 ));  % calcula distancia euclidiana dos pivos
    end

    % Plota histograma
    
    for classe = 1:npivos
        close all;
        dist = dist_pivo(kind == classe);
        MAX = max(dist); % maxima distancia
        histo = zeros(nbuckets,1);
        acum_histo = zeros(nbuckets,1);
        for i = 1:nbuckets
            histo(i) = sum( dist >= (i-1)*MAX/nbuckets &  dist < i*MAX/nbuckets ); % valores de frequencia do histograma
            if i == 1
                acum_histo(i) = histo(i); % valores de frequencia acumulada no histograma
            else
                acum_histo(i) = histo(i) + acum_histo(i-1); % valores de frequencia acumulada no histograma
            end
        end
        dist_norm = dist/MAX;
        classes = linspace(0,1,nbuckets);
        dist_medio = mean(dist_norm);
        dist_desvio = sqrt(mean( (dist_norm - dist_medio ).^2 ) );
        dist_inside = mean(abs(dist_norm - dist_medio) <= dist_desvio);

        figure
        plot(classes,histo/max(histo),'k')
        ylabel('Frequency')
        xlabel('Normalized Pivot Distance')
        title(['Pivoted Distance Histogram for ',num2str(nbuckets),' buckets from ',file_name,' - number of variables = ',num2str(dim),' - mean = ',num2str(dist_medio),' - standard deviation = ',num2str(dist_desvio),' - ',num2str(100*dist_inside),'% inside 1 std'])  % histograma 
        saveas(gcf,['Resultados/',file_name,'/pivo_',num2str(classe),'_histo_',num2str(nbuckets),'buckets_from_',file_name,'_',num2str(dim),'variables_mean',num2str(dist_medio),'_std',num2str(dist_desvio),'.png']);

        figure
        plot(classes,acum_histo/max(acum_histo),'k')
        ylabel('Frequency')
        xlabel('Normalized Pivot Distance')
        title(['Pivoted Distance Cumulative Histogram for ',num2str(nbuckets),' buckets from ',file_name,' - number of variables = ',num2str(dim),' - mean = ',num2str(dist_medio),' - standard deviation = ',num2str(dist_desvio),' - ',num2str(100*dist_inside),'% inside 1 std'])  % histograma acumulado
        saveas(gcf,['Resultados/',file_name,'/pivo_',num2str(classe),'_cumulative_histo_',num2str(nbuckets),'buckets_from_',file_name,'_',num2str(dim),'variables_mean',num2str(dist_medio),'_std',num2str(dist_desvio),'.png']);
    end
end