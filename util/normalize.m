function normalized_v = normalize(v)
    normalized_v = zeros(size(v));
    for j = 1:size(v,2)
        if (max(v(:,j)) - min(v(:,j))) ~= 0
            normalized_v(:,j) = (v(:,j) - min(v(:,j)))/(max(v(:,j)) - min(v(:,j)));
        elseif max(v(:,j)) ~= 0
            normalized_v(:,j) = v(:,j)/max(v(:,j));
        else
            normalized_v(:,j) = v(:,j);
        end
    end
end