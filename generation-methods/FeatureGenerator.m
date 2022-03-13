function v = FeatureGenerator(v,generator_type)
    N = size(v,1);
    if strcmp(generator_type,'uniform')
         maximo = max(v(:));
         minimo = min(v(:));
         v(:,end+1) = (maximo-minimo)*rand(N,1)+minimo; % gera coordenadas de uma distro uniforme
    elseif strcmp(generator_type,'normal')
        media = mean(v(:));
        desvio = sqrt(mean(v(:).^2) - media.^2);
        v(:,end+1) = (randn(N,1)*desvio + media); % gera coordenadas de uma distro normal
    elseif strcmp(generator_type,'normal2')
        media = mean(v(:));
        desvio = rand(N,1);
        v(:,end+1) = (randn(N,1).*desvio+media);
    else
         error('Error at FeatureGenerator function. Feature generator type unknown') % error case
    end
end