function [new_particles, new_weights] = resample(particles, weights, frame)
    %  Multinominal resampling
    % take best 10 pixels to resample the worse pixels around them instead
    [B, I] = maxk(weights, 10); % return 10 largest weights 
    M = length(particles(:,1));
    cdf = cumsum(weights);

  
    
    new_particles = zeros(M,5);
    new_weights = zeros(1,M);
    % we remove the pixels belowe the limit
    for i=1:length(particles(:,1))
        r_n = rand;
        k = find(cdf >= r_n, 1, 'first');
        new_particles(i,:) = particles(k,:);
        new_weights(i) = weights(k);
        
        %if weights(i) < limit
        %    particles(i,:) = [];
        %end
    end

    new_weights = 1/M*ones(size(weights));
    
end