function main(file_name,distance_type,selector_type,generator_type,nAtribWanted,dataset_type)
     % read dataset
    location = 'datasets/';
    tic
    fprintf(['Reading the ',file_name,' dataset file...'])
    dataset = load([location,file_name,'.csv']);
    
    if strcmp(dataset_type,'supervised')
        dataset = dataset(:,1:end-1);
    elseif strcmp(dataset_type,'unsupervised')
        % do nothing
    else
        error('Dataset type is not valid!! ')
    end
    
    dataset = normalize(dataset);
    fprintf('The time to read the file was %f seconds\n',toc)
    nAtrib = size(dataset,2);
    nAtribWanted = nAtribWanted(:);
    nAtribWanted = sort(nAtribWanted); 
    if ~all(nAtribWanted ~= nAtrib)
        if strcmp(selector_type,'Pearson')
            reduction_method = 'naive';
        else
            reduction_method = selector_type;
        end  
        datasetPairwiseDistance(dataset,file_name,distance_type,reduction_method)   
    end
    if ~isempty(selector_type) && ~all(nAtribWanted >= nAtrib)
         fprintf('Starting atribute reduction...\n')
        datasetAtribReduction(dataset,file_name,distance_type,selector_type,nAtribWanted)
    end
    if ~isempty(generator_type) && ~all(nAtribWanted <= nAtrib)
         fprintf('Starting atribute generation...\n')
        datasetAtribGeneration(dataset,file_name,distance_type,generator_type,nAtribWanted)
    end
%     least_squares(file_name,distance_type,nAtribWanted,1:n,0:max(nAtribWanted)) % 
end
