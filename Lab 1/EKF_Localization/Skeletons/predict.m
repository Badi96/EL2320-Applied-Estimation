% This function performs the prediction step.
% Inputs:
%           mu(t-1)           3X1   
%           sigma(t-1)        3X3
%           u(t)              3X1
% Outputs:   
%           mu_bar(t)         3X1
%           sigma_bar(t)      3X3
function [mu_bar, sigma_bar] = predict(mu, sigma, u)
    
    global R % covariance matrix of motion model | shape 3X3
  
    % YOUR IMPLEMENTATION %
    g = mu + u; % g( u_t, mu_(t-1) )
    mu_bar = g;
    %delta_t_times_v_t = u(1)/cos(mu(3)); 
    G_t = [1, 0, -u(2); 0, 1, u(1); 0, 0, 1];
    %G_t = [1, 0, -1*u(1)*sin(mu(3))/cos(mu(3)) ; 0, 1, u(1)*sin(mu(3))/cos(mu(3)) ; 0, 0, 1];
    sigma_bar = G_t * sigma * G_t' + R;
  

end