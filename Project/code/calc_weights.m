function weights = calc_weights(particles, ref_hist, ref_edges)
M = size(particles, 1);
weights = zeros(1, M);
for i = 1 : M
    prob_red = 0;
    % loop all edges
    for k = 2:length(ref_edges(1,:))
        % find the edge that we are supposed to use
        if particles(i, 1) <= ref_edges(1,k)
            prob_red = ref_hist(1,k-1);
            break
        end     
    end
    %prob_red
    if particles(i, 1) <= ref_edges(1,1)
        prob_red = 0;
    end
    
    
    prob_blue = 0;
    % loop all edges
    for k = 2:length(ref_edges(2,:))
        % find the edge that we are supposed to use
        if particles(i, 2) <= ref_edges(2,k)
            prob_blue = ref_hist(2,k-1);
            break
        end     
    end
    if particles(i, 2) <= ref_edges(2,1)
        prob_blue = 0;
    end
    
    prob_green = 0;
    % loop all edges
    for k = 2:length(ref_edges(3,:))
        % find the edge that we are supposed to use
        if particles(i, 3) <= ref_edges(3,k)
            prob_green = ref_hist(3,k-1);
            break
        end     
    end
    if particles(i, 3) <= ref_edges(3,1)
        prob_green = 0;
    end
    
    weights(1,i) = (prob_red+prob_green+prob_blue)/3;
    
end

weights = weights/sum(weights);

end