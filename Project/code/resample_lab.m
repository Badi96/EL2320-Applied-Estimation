function particles_new=resample(particles_old,weight)
    % Multinomial resampling
    cdf=cumsum(weight);
    particles_new_=zeros(2,size(particles_old,1));
    for m=1:size(particles_old,2)
        rm=rand;
        i=find(cdf>=rm,1,'first');
        if not(i==0)
            particles_new_(:,m)=particles_old(1:2,i);
        end
    end
    particles_new=[particles_new_;(1/size(particles_old,1))*ones(1,size(particles_old,1))]';
end
