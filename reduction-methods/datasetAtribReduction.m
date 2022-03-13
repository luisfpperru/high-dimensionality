function datasetAtribReduction(dataset,file_name,distance_type,selector_type,nAtribWanted)
    nAtribWanted = nAtribWanted(:);
    nAtrib = size(dataset,2);
    nAtribWanted = nAtribWanted(nAtribWanted < nAtrib);
    if ~isempty(nAtribWanted)
        if strcmp(selector_type,'Pearson')
            reduction_method = 'naive';     
 
            % Calculate correlation matrix
            fprintf('Calculating the correlation matrix...Progress...')
            tic
            Correlation_Matrix = zeros(nAtrib,nAtrib);
            size_string = 0;
            for i = 1:nAtrib
                for j = 1:i-1
                    Correlation_Matrix(i,j) = abs(FeatureSelector(dataset(:,i),dataset(:,j),selector_type)); 
                    Correlation_Matrix(j,i) = Correlation_Matrix(i,j);
                    if toc > 0.5
                        fprintf(repmat('\b',[1,size_string]));
                        num = [num2str(100*(( (i-2)*(i-1)/2+j)/(nAtrib*(nAtrib-1)/2) )),'%'];
                        fprintf('%s',num);
                        size_string = length(num);
                        tic
                    end
                end
            end
            fprintf(repmat('\b',[1,size_string]));
            num = [num2str(100),'%'];
            fprintf('%s\n',num);
%             fprintf('Saving correlation matrix...\n')
%             status = 1;
%             if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
%                  status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
%             end
%             if status == 1
%                 save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/correlation_matrix_',file_name,'.txt'],'Correlation_Matrix','-ascii','-double');        
%             end
        % iterate atribute elimination
        while ~isempty(nAtribWanted)
            % select the two atributes with maximum correlation between them
            [~,ind] = max(Correlation_Matrix(:));
            Atrib1 = mod(ind-1,nAtrib)+1; 
            Atrib2 = (ind - Atrib1)/nAtrib+1;
            % sort correlations with respect the two selected atributes
            v1 = sort(Correlation_Matrix(:,Atrib1));
            v2 = sort(Correlation_Matrix(:,Atrib2));
            if v1(end) <= v2(end) 
                dataset(:,Atrib1) = [];
                Correlation_Matrix(:,Atrib1) = [];
                Correlation_Matrix(Atrib1,:) = [];
                nAtrib = nAtrib - 1;
            else
                dataset(:,Atrib2) = [];
                Correlation_Matrix(:,Atrib2) = [];
                Correlation_Matrix(Atrib2,:) = [];
                nAtrib = nAtrib - 1;
            end
            if ~all(nAtrib ~= nAtribWanted)
                 fprintf('Saving new dataset with %d atributes...\n',nAtrib)
                 status = 1;
                 if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
                     status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
                 end
                 if status == 1
                     save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/reduced_dataset_',file_name,'_',num2str(nAtrib),'atributes_',distance_type,'.txt'],'dataset','-ascii','-double');        
                 end
                datasetPairwiseDistance(dataset,file_name,distance_type,reduction_method)
            end
            nAtribWanted(nAtrib == nAtribWanted) = [];
        end
        elseif strcmp(selector_type,'PCA')
            reduction_method = selector_type;
            for i = 1:size(nAtribWanted,1)
                  [~,new_dataset] = pca(dataset,'NumComponents',nAtribWanted(i));
                  new_dataset = normalize(new_dataset);
                  fprintf('Saving new dataset with %d atributes...\n',nAtribWanted(i))
                 status = 1;
                 if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
                     status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
                 end
                 if status == 1
                     save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/reduced_dataset_',file_name,'_',num2str(nAtribWanted(i)),'atributes_',distance_type,'.txt'],'new_dataset','-ascii','-double');        
                 end
               datasetPairwiseDistance(new_dataset,file_name,distance_type,reduction_method)
            end
        elseif strcmp(selector_type,'FastMap')
            reduction_method = selector_type;
            for i = 1:size(nAtribWanted,1)
               new_dataset = FastMap(dataset,nAtribWanted(i));
               new_dataset = normalize(new_dataset);                
                   fprintf('Saving new dataset with %d atributes...\n',nAtribWanted(i))
                 status = 1;
                 if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
                     status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
                 end
                 if status == 1
                     save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/reduced_dataset_',file_name,'_',num2str(nAtribWanted(i)),'atributes_',distance_type,'.txt'],'new_dataset','-ascii','-double');        
                 end
               datasetPairwiseDistance(new_dataset,file_name,distance_type,reduction_method)
            end
        elseif strcmp(selector_type,'KernelPCA')
               reduction_method = selector_type;
                for i = 1:size(nAtribWanted,1)
                    new_dataset = kernel_pca(dataset,nAtribWanted(i));
                    new_dataset = normalize(new_dataset);                
                      fprintf('Saving new dataset with %d atributes...\n',nAtribWanted(i))
                 status = 1;
                 if ~exist(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name], 'dir') %  check if folder exists
                     status = mkdir(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name]); % case not, attempt to create the folder
                 end
                 if status == 1
                     save(['Bedo-Perru/plots/',reduction_method,'/histograms/',file_name,'/reduced_dataset_',file_name,'_',num2str(nAtribWanted(i)),'atributes_',distance_type,'.txt'],'new_dataset','-ascii','-double');        
                 end
                    
                    datasetPairwiseDistance(new_dataset,file_name,distance_type,reduction_method)
                end
        else
                error('Error at atribute reduction function. Feature selector type unknown') % error case
        end            
    end
end