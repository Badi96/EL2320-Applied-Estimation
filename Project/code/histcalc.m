function [red_hist,green_hist,blue_hist]=histcalc(image, gridsize, edges_ref_red, edges_ref_green, edges_ref_blue)
[size_y, size_x,~]=size(image);
red_hist=zeros(size_y/gridsize,size_x/gridsize,8);
green_hist=zeros(size_y/gridsize,size_x/gridsize,8);
blue_hist=zeros(size_y/gridsize,size_x/gridsize,8);
red=image(:,:,1);
green=image(:,:,2);
blue=image(:,:,3);

for rows=1:size_y/gridsize
    for columns=1:size_x/gridsize
        
        [N_red,~]=histcounts(red(rows*gridsize-gridsize+1:rows*gridsize,columns*gridsize-gridsize+1:columns*gridsize), edges_ref_red, 'Normalization', 'probability');
        [N_green,~]=histcounts(green(rows*gridsize-gridsize+1:rows*gridsize,columns*gridsize-gridsize+1:columns*gridsize), edges_ref_green, 'Normalization', 'probability');
        [N_blue,~]=histcounts(blue(rows*gridsize-gridsize+1:rows*gridsize,columns*gridsize-gridsize+1:columns*gridsize), edges_ref_blue, 'Normalization', 'probability');

        red_hist(rows,columns,:)=N_red;
        green_hist(rows,columns,:)=N_green;
        blue_hist(rows,columns,:)=N_blue;

    end
end