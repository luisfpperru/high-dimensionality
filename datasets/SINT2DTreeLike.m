% Geração de dados sintéticos bidimensionais em forma de árvore
function SINT2DTreeLike(N)  % N é a dimensão do problema sendo que 3*N+1 é o número de pontos gerados

% Exemplo de uso:
%
%    SINT2DTreeLike(100); 
%    SINT2DTreeLike(500);

	v(1,1) = 0;
	v(1,2) = 0;
	v(2,1) = 1;
	v(2,2) = 0;
	v(3,1) = 0;
	v(3,2) = 1;
	v(4,1) = 1;
	v(4,2) = 1;
	for i=1:N
  		v(4*i+1,1) = 1/2^i;
  		v(4*i+1,2) = 1/2^i;
  		v(4*i+2,1) = 0;
  		v(4*i+2,2) = 1/2^i;
  		v(4*i+3,1) = 1/2^i;
  		v(4*i+3,2) = 0;
	end
    save('datasets/tree_like.csv','-ascii','-double','v');
end
