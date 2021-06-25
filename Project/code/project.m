clear;
close all;
% import video
v = VideoReader('Easy_scene.mp4');
%v = VideoReader('Advanced_Scene.mp4');
frame=readFrame(v);
%return 

%colorcloud(frame, 'hcv')
%return
[x_size,y_size,~] = size(frame);

%grid_size=25;

%bounding_box = [int64(835/grid_size) int64(880/grid_size); int64(325/grid_size) int64(375/grid_size)];
% bounding box: to initialize our histograms. but not using anymore. 

%y 131 -  254
%x 747 - 868

% changes to calculate the weights based on the probabbility instead of
% using bc_calc. We thus have no spacial distance and only using colour
% distnces. 

% Reference frame histograms
ref_frame = frame(835:880, 325:375, :); % the reference to our ball in the first frame

%ref_frame = frame(747:868, 131:254, :);
% eight bits for the color, 2^8 so 0-255 values for each color in RGB.
% Probability distriution som target distribution. Also normalize the value
% of the histograms for the colours



% my own part for plotting the different hisotgrams and the reference ball
% subplot(1,3,1)
% histogram(ref_frame(:,:,1), 'FaceColor','red')
% hold on
% %histogram(ref_frame(:,:,1),'FaceColor','red');
% title("Red Histogram")
% xlabel('Red intensity bins')
% ylabel('Number of pixels')
% hold off
% 
% subplot(1,3,2)
% histogram(ref_frame(:,:,2), 'FaceColor','green')
% hold on
% title("Green Histogram")
% xlabel('Green intensity bins')
% ylabel('Number of pixels')
% hold off
% 
% subplot(1,3,3)
% histogram(ref_frame(:,:,3), 'FaceColor','Blue')
% hold on
% title("Blue Histogram")
% xlabel('Blue intensity bins')
% ylabel('Number of pixels')
% hold off
% 
% figure 
% imshow(ref_frame)
% return


[ref_frame_hist_red,edges_ref_red] = histcounts(ref_frame(:,:,1),8, 'Normalization', 'probability');
[ref_frame_hist_green,edges_ref_green] = histcounts(ref_frame(:,:,2),8, 'Normalization', 'probability');
[ref_frame_hist_blue,edges_ref_blue] = histcounts(ref_frame(:,:,3),8, 'Normalization', 'probability');
%histogram(histcounts(ref_frame(:,:,1),8, 'Normalization', 'probability'))
%  
ref_hist = [ref_frame_hist_red; ref_frame_hist_green; ref_frame_hist_blue];
ref_edges = [edges_ref_red; edges_ref_green; edges_ref_blue]; % corresponding edges of the histogram
M=10000; %number of particles
particles=zeros(M,5); % particles: y, x, r ,g ,b 
particles(1:M,4)=randi(x_size,M,1);
particles(1:M,5)=randi(y_size,M,1);
for i=1:M
    particles(i,1)=frame(particles(i,4),particles(i,5),1);
    particles(i,2)=frame(particles(i,4),particles(i,5),2);
    particles(i,3)=frame(particles(i,4),particles(i,5),3);
end

current_position= [0 0];
weights=calc_weights(particles, ref_hist, ref_edges);
[B, I] = maxk(weights, 20); % take 20 highest weights for estimating ball
new_particles = particles(I,4:5);

for k=1:length(new_particles(:,1))
    frame(new_particles(k,1), new_particles(k,2), 1) = 0;
    frame(new_particles(k,1), new_particles(k,2), 2) = 255;  % Draw out the green pixel
    frame(new_particles(k,1), new_particles(k,2), 3) = 0;
    current_position(1) = current_position(1) + new_particles(k,1); % add the positions for average
    current_position(2) = current_position(2) + new_particles(k,2);
end
current_position(1) = current_position(1)/20; %  Divide by 20, take average of positions. 
current_position(2) = current_position(2)/20;

hold on
imshow(frame)
old_positions = [850 350];
q=0
[particles, weights] = resample(particles, weights, frame);
while hasFrame(v)
    frame=readFrame(v);
    [particles, weights] = resample(particles, weights, frame);
    
    movement = prediction(current_position, old_positions);
    particles = move_particles(particles, movement);
    old_positions = current_position;
        
    for i=1:M
        particles(i,1)=frame(particles(i,4),particles(i,5),1);
        particles(i,2)=frame(particles(i,4),particles(i,5),2);
        particles(i,3)=frame(particles(i,4),particles(i,5),3);
           
        frame(particles(i,1), particles(i,2), 1) = 0;
        frame(particles(i,1), particles(i,2), 2) = 255;  % Draw out the green pixel
        frame(particles(i,1), particles(i,2), 3) = 0;
        
    end
    weights=calc_weights(particles, ref_hist, ref_edges);
    
    [B, I] = maxk(weights, 20);
    current_position=[0 0];
    new_particles = particles(I,4:5);
    for k=1:length(new_particles(:,1))
        new_particles(k,1)
        frame(new_particles(k,1), new_particles(k,2), 1) = 0;
        frame(new_particles(k,1), new_particles(k,2), 2) = 255; 
        frame(new_particles(k,1), new_particles(k,2), 3) = 0;
        current_position(1) = current_position(1) + new_particles(k,1);
        current_position(2) = current_position(2) + new_particles(k,2);
    end
    current_position(1) = current_position(1)/20;
    current_position(2) = current_position(2)/20;
    imshow(frame)
    
end

% Future work: Use bounding box for comparing hostograms of particle
% regions directly with the reference frama. Also use Balcharry distance to
% measure the distance of particles in spacial domain and not just in color
% distance. 

