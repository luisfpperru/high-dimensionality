% geração de dados sintéticos bidimensionais  uniformes
function SINT2DUniforme(N)  % N é dimensão do problema sendo que N^2 é o número de pontos gerados

% Exemplo de uso:
%
%    SINT2DUniforme(50); 
%

	x = linspace(0,1,N); % coordenada x
	y = linspace(0,1,N); % coordenada y
	v = zeros(N^2,2); 
	for i = 1:N
    		for j = 1:N
        		v((i-1)*N+j,1) = x(i); 
        		v((i-1)*N+j,2) = y(j);
   		end
	end
    save('datasets/uniform.csv','-ascii','-double','v');
end
