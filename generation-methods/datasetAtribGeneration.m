function datasetAtribGeneration(dataset,file_name,distance_type,generator_type,nAtribWanted)
    nAtrib = size(dataset,2);
    nAtribWanted = nAtribWanted(nAtribWanted > nAtrib);
    while ~isempty(nAtribWanted)
            dataset = FeatureGenerator(dataset,generator_type); % generates exacty one extra atribute
            nAtrib = nAtrib + 1;
            if ~all(nAtrib ~= nAtribWanted)
                 fprintf('Saving new dataset with %d atributes...\n',nAtrib)
                 status = 1;
                 if ~exist(['Bedo-Perru/plots/',generator_type,'/histograms/',file_name], 'dir') %  check if folder exists
                     status = mkdir(['Bedo-Perru/plots/',generator_type,'/histograms/',file_name]); % case not, attempt to create the folder
                 end
                 if status == 1
                     save(['Bedo-Perru/plots/',generator_type,'/histograms/',file_name,'/generated_dataset_',file_name,'_',num2str(nAtrib),'atributes_',distance_type,'.txt'],'dataset','-ascii','-double');        
                 end
                 datasetPairwiseDistance(dataset,file_name,distance_type,generator_type)
            end
            nAtribWanted(nAtrib == nAtribWanted) = [];
    end
end
