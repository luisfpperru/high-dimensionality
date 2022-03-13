function newA = FastMap(A,k)

% This original implementation is available in following website:
%  http://www.db-net.aueb.gr/panagis/TKDD2009/  
% Acess in: 13/09/2016 4pm . All the rights are reserved to the authors. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      The FastMap algorithm                              %
%Implementation based on the algorithm outlined in paper:                 %
%"FastMap: A Fast Algorithm for Indexing, Data-Mining and Visualization of%
%Traditional and Multimedia Datasets" by  Christos Faloutsos and King-Ip  %
%(David) Lin. Published in 1995 ACM SIGMOD                                %
%                                                                         %
%Input:                                                                   %
%   1. fileName: The name of the file that carries the data to be used    %
%   2. delimiter: The delimiter that separates data coordinates           %
%   3. k: The projection dimensionality                                   %
%   4. distances: Whether we should calculate distances                   %
%                                                                         %
%Output:                                                                  %
% A file with the name $fileName.FastMap which carries the projected      %
% dataset                                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Read data from input file
%A = dlmread(fileName,delimiter);
 lines=size(A,1);
% 
% distFileName = strcat(fileName,'.distances');
% D = zeros(lines,lines);
% if(distances == 1)
%     %Calculate distances - this may take a while but we are doing it once!
%     for i=1:1:lines
%         D(i,i) = 0;
%         for j=(i+1):1:lines
%             D(i,j) = sum((A(i,:)-A(j,:)).^2).^(0.5);
%             D(j,i) = D(i,j);
%         end
%     end    
%     dlmwrite(distFileName,D);    
% end
% 
% clear D;
% pack;
   
%Initialize new data matrix
newA=zeros(lines,k);

for repetition=1:1:10
%     t0=cputime();
%     x=0;
    %For required number of coordinates
    for i=1:1:k
        %Randomly select an index
        a = 1; 
        b = lines;
        randIndex = round(a + (b-a) * rand(1));

        %Find the pivots
        D=zeros(1,lines);
        for j=1:1:lines
            D(1,j) = sum((A(j,:) - A(randIndex,:)).^2) - sum((newA(j,:) - newA(randIndex,:)).^2);
            if(D(1,j)<=1.0e-10)
                D(1,j)=0;
            end
            D(1,j) = sqrt(D(1,j));
        end
        [~,firstPivot] = max(D);
    
        D=zeros(1,lines);
        for j=1:1:lines
            D(1,j) = sum((A(j,:) - A(firstPivot,:)).^2) - sum((newA(j,:) - newA(firstPivot,:)).^2);
            if(D(1,j)<=1.0e-10)
                D(1,j)=0;
            end
            D(1,j) = sqrt(D(1,j));            
        end        
        [pivotDistance,secondPivot] = max(D);

        %No need to continue, everything is zero from now on
%         if(abs(pivotDistance) == 0)
%             tmp2=strcat(fileName,strcat('.k=',int2str(k)));
%             tmp3=strcat(tmp2,strcat('.rep=',int2str(repetition)));    
%             newFileName=strcat(tmp3,'.FastMap');             
%             %Write data into file
%             dlmwrite(newFileName,newA);
%             continue;
%         end

        %Calculate new coordinates - the cosine law
        for j=1:1:lines
            aj = (sum((A(j,:) - A(firstPivot,:)).^2) - sum((newA(j,:) - newA(firstPivot,:)).^2));
            if(aj<1.0e-10)
                aj=0;
            end
            bj = (sum((A(j,:) - A(secondPivot,:)).^2) - sum((newA(j,:) - newA(secondPivot,:)).^2));
            if(bj<1.0e-10)
                bj=0;
            end
            ab = pivotDistance;
            newA(j,i) = (aj + ab^2 - bj)/(2*ab);
        end

        %Calculate new distances - Pythagorean theorem
%         for j=1:1:lines
%             D(j,j)=0;
%             for l=j+1:1:lines
%                 if(D(j,l)^2 - (newA(l,i) - newA(j,i))^2<=1.0e-10)
%                     D(j,l) = 0;
%                     D(l,j) = 0;
%                 else
%                     D(j,l)= sqrt(D(j,l)^2 - (newA(l,i) - newA(j,i))^2);
%                     D(l,j)=D(j,l);
%                 end
%             end
%         end       

    end

%     tmp2=strcat(fileName,strcat('.k=',int2str(k)));
%     tmp3=strcat(tmp2,strcat('.rep=',int2str(repetition)));    
%     newFileName=strcat(tmp3,'.FastMap');             
%     %Write data into file
%     dlmwrite(newFileName,newA);
% 
%     %Inform the user
%     s = strcat('Computation finished successfully. Results are in file: ', newFileName);
%     disp(s);
% 
%     t1=cputime();
%     elapsedTime = t1-t0;
%     
% 	Str = Stress(fileName,newFileName,delimiter);
%     tmp=strcat(fileName,strcat('.k=',int2str(k)));
%     NewFileName = strcat(tmp,'.FASTMAP.results');   
%     printStatistics(NewFileName,1,'================================');
%     printStatistics(NewFileName,1,'FASTMAP');
%     printStatistics(NewFileName,1,'================================');
%     printStatistics(NewFileName,1,strcat('Repetition:',int2str(repetition)));
%     printStatistics(NewFileName,1,strcat('K:',int2str(k)));
%     printStatistics(NewFileName,1,strcat('Time:',num2str(elapsedTime)));
%     printStatistics(NewFileName,1,strcat('Stress:',num2str(Str)));
    
end
