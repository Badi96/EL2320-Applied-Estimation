% This function is the implementation of the measurement model.
% The bearing should be in the interval [-pi,pi)
% Inputs:
%           S(t)                           4XM
%           j                              1X1
% Outputs:  
%           h                              2XM
function z_j = observation_model(S, j)

    global map % map including the coordinates of all landmarks | shape 2Xn for n landmarks
    global M % number of particles
    
    % YOUR IMPLEMENTATION
    %disp("map is:");
    %disp(size(map));
    % map is the weights in this case  
    h = zeros(2, M);
    h(1,:) = sqrt((map(1, j)-S(1,:)).^2 + (map(2,j) -S(2,:)).^2);
    h(2,:) = atan2(map(2,j)-S(2,:),map(1,j)-S(1,:)) - S(3,:);
    h(2,:) = mod(h(2,:)+pi, 2*pi) -pi;
    %h_1 = [sqr((map(1, j)-S(1))^2 + (map(2,j) -S(2))^2); atan2(map(2,j)-x(2),map(1,j)-x(1)) - x(3)]
    
    h_2_angle = mod(h(2,:) + pi, 2*pi) - pi;
    h = [h(1,:); h_2_angle];
    z_j = h; %  no delta_t in the simulations. 

end