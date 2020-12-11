% This function calcultes the weights for each particle based on the
% observation likelihood
%           S_bar(t)            4XM
%           outlier             1Xn
%           Psi(t)              1XnXM
% Outputs: 
%           S_bar(t)            4XM
function S_bar = weight(S_bar, Psi, outlier)

    % YOUR IMPLEMENTATION
    global lambda_psi; % added myself, maybe don't need. 
    psi_no_outliers = Psi(1, find(~outlier), :); %find all elements in Psi that is not an outlier. 
    weighted_products = prod(psi_no_outliers, 2); % take products of all Psi over all observations. Do for all particles. 
    S_bar(4,:) = weighted_products./ sum(weighted_products); % weigts for all particles. normalize weights.  
   
end
