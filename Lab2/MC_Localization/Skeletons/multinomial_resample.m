% This function performs multinomial re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = multinomial_resample(S_bar)

    global M % number of particles
    cdf = zeros(1,M);
    S = zeros(size(S_bar));
    % YOUR IMPLEMENTATION
    for m = 1:M
        cdf(m) = sum(S_bar(4,1:m)); % sum all weights for particles. 
    end
    % for all particles 
    for m = 1:M
        r_m = rand(1); % random sample, uniform dist.
        % find first element in cdf that satisfies argmin j cdf(j) >= r_m
        i = find(cdf >= r_m, 1, 'first'); % find first index
        S(:,m) = S_bar(:,i);
        S(4,m) = 1/M; % re-weight the particles.
       
    end

end
