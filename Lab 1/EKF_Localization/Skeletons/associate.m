% This function performs the maximum likelihood association and outlier detection given a single measurement.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           z_i(t)              2X1
% Outputs: 
%           c(t)                1X1
%           outlier             1X1
%           nu^i(t)             2XN
%           S^i(t)              2X2XN
%           H^i(t)              2X3XN
function [c, outlier, nu, S, H] = associate(mu_bar, sigma_bar, z_i)

    % Import global variables
    global Q % measurement covariance matrix | 1X1
    global lambda_m % outlier detection threshold on mahalanobis distance | 1X1
    global map % map | 2Xn
    a = size(map);
    N = a(2); % number of landmarks
    phi_vec = []; %likelihoods
    H_vec = [];
    S_vec = [];
    nu_vec = [];
 
    for j = 1:N
        h = observation_model(mu_bar, j);
        z_bar = h;
        H_vec(:,:,j) = jacobian_observation_model(mu_bar, j, z_bar);
        S_vec(:,:,j) = H_vec(:,:,j)*sigma_bar*(H_vec(:,:,j)') + Q;
      
        nu_vec(:,j) = z_i - z_bar;
        %check that second element in nu_vec is between -pi and pi
        nu_vec(2,j) = mod(nu_vec(2,j) + pi, 2*pi) -pi;
        phi_vec(:,j) = ( 1/sqrt(det(2*pi*S_vec(:,:,j))) )*exp(-0.5*( (nu_vec(:,j)')*(inv(S_vec(:,:,j)))*nu_vec(:,j)) );
    end
    % YOUR IMPLEMENTATION %
    maximum = max(phi_vec);
    c = find(phi_vec == maximum); % argmax
    nu = nu_vec;
    S = S_vec;
    H = H_vec;
    
    D_m = (nu_vec(:,c)')*( inv(S_vec(:,:,c)) )*nu_vec(:,c); 
    if D_m > lambda_m
        outlier = 1;
    elseif D_m < lambda_m
        outlier = 0;
    end
end