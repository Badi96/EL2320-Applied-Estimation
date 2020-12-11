% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = systematic_resample(S_bar)
	
    global M % number of particles 
    cdf = zeros(1,M);
    % YOUR IMPLEMENTATION
    S = zeros(4,M);
    for i = 1:M
        cdf(i) = sum(S_bar(4,1:i));
    end
    
    r_0 = (1/M)*rand(1); % generate random uniform between [0, 1/M]
    for m=1:M
        r = r_0 + (m-1)/M;
        i = find(cdf >=r, 1, 'first'); % rfind first index to be large enough in cdf  
        S(:,m) = S_bar(:,i); % exract the right index 
        S(4,m) = 1/M; %re-weight 
    end
end