% This function performs the ML data association
%           S_bar(t)                 4XM
%           z(t)                     2Xn
%           association_ground_truth 1Xn | ground truth landmark ID for
%           every measurement
% Outputs: 
%           outlier                  1Xn
%           Psi(t)                   1XnXM
function [outlier, Psi, c] = associate(S_bar, z, association_ground_truth)
    if nargin < 3
        association_ground_truth = [];
    end

    global DATA_ASSOCIATION % wheter to perform data association or use ground truth
    global lambda_psi % threshold on average likelihood for outlier detection
    global Q % covariance matrix of the measurement model
    global M % number of particles
    global N % number of landmarks
    global landmark_ids % unique landmark IDs
    global map
    
    % one of my old implementations that seems to kind of work...
    
    % YOUR IMPLEMENTATION
    %disp(size(map))
    n = size(z,2); % number of observations 
    diag_inverse_Q = diag(inv(Q)); 
    Q_new = repmat(diag_inverse_Q, [1 N M]); % Larger Q matrix for faster computation 
    
    % for all landmarks
    zhat = zeros(2,N,M); 
    for k = 1:N
        zhat(:,k, : ) = observation_model(S_bar, k);
        zhat(2,k,:) = mod(zhat(2,k,:)+pi,2*pi)-pi;
    end
    normalization_term = 1/(2*pi*sqrt(det(Q)));
 
    %disp("Q has size: ")
    %disp(size(Q))
    
    %for all observations
    for i = 1:n
        mu = repmat(z(:,i),1, N, M) -zhat; 
        mu(2,:,:) = mod(mu(2,:,:) + pi, 2*pi) - pi;
        
        max_value = max(normalization_term * exp(sum(-0.5 .* mu .* Q_new .* mu, 1)));
        Psi(1,i,:) = max_value;
        c(i,:) = find(Psi(1,i,:)==max_value); % index for each max value. 
        %Psi_bar = sum(Psi(1,i,:));
        %disp(size(Psi(1,i,:)));
        outlier(1,i) = lambda_psi >  mean(Psi(1,i,:));
    end
    
    %outlier = mean(reshape(Psi, n, M),2) <= lambda_psi;



    
end