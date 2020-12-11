% This function performs the prediction step.
% Inputs:
%           S(t-1)            4XN
%           v                 1X1
%           omega             1X1
% Outputs:   
%           S_bar(t)          4XN
function [S_bar] = predict(S, v, omega, delta_t)

    % Comment out any S_bar(3, :) = mod(S_bar(3,:)+pi,2*pi) - pi before
    % running the test script as it will cause a conflict with the test
    % function. If your function passes, uncomment again for the
    % simulation.

    global R % covariance matrix of motion model | shape 3X3
    global M % number of particles
    
    % YOUR IMPLEMENTATION
   
     S(1,:) = S(1,:) + v * cos(S(3,:)) * delta_t + R(1,1) .* randn(1,M);
     S(2,:) = S(2,:) + v * sin(S(3,:)) * delta_t + R(2,2) .* randn(1,M) ;
     S(3,:) = S(3,:) + omega * delta_t + + R(3,3) .* randn(1,M);
     S_bar = S;
     S_bar(3, :) = mod(S_bar(3,:)+pi,2*pi) - pi; % comment away during tests
     

    
end