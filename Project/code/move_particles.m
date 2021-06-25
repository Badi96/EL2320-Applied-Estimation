function particles=move_particles(particles, movement)
    covar = normrnd(1,0.2,[1,length(particles(:,1))]); % covariance
    particles(:,4) = int64(particles(:,4)+movement(1)*covar(:));
    particles(:,5) = int64(particles(:,5)+movement(2)*covar(:));
    
    y1 = find(particles(:,4)>1050);
    y2 = find(particles(:,4)<1);
    x1 = find(particles(:,5)>750);
    x2 = find(particles(:,5)<1);
    particles(y1,4) = 1050;
    particles(y2,4) = 1;
    particles(x1,5) = 750;
    particles(x2,5) = 1;
end