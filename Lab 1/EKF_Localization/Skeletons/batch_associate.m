% This function performs the maximum likelihood association and outlier detection.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           z(t)                2Xn
% Outputs: 
%           c(t)                1Xn
%           outlier             1Xn
%           nu_bar(t)           2nX1
%           H_bar(t)            2nX3
function [c, outlier, nu_bar, H_bar] = batch_associate(mu_bar, sigma_bar, z)
    c_temp = [];
    outlier = [];
    nu_bar_temp = [];
    nu_bar = [];
    H_bar = [];
    n = size(z);
    N = n(2);
    for i = [1:N]
        [c_i, outlier_i, nu, S, H_i] = associate(mu_bar, sigma_bar, z(:,i));
        c(:,i) = c_i; % klar
        outlier(:,i) = outlier_i; % klar
        
        nu_bar =[nu_bar; nu(:,c_i)];
        
        %nu_bar_temp(2*i,:) = nu;
        H_bar =[H_bar; H_i(:,:,c_i)];
    
        %nu_bar = nu_bar_temp;
    end
    

        
end