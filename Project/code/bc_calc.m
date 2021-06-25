function distance = bc_calc(measurements, reference)
%distance = bhattacharyyaDistance(measurements{:,:},reference{:,:});
%distance=zeros(42,30)
%distance = zeros(size(measurements));

%distance(:,:)=sum((measurements(:,:,:).*reference(:,:,:)).^0.5,3)
%sum( (measurements.*reference).^0.5, 3)
distance=sqrt(1 - sum( (measurements.*reference).^0.5, 3) );
end