function print_ball_box(frame, b_box)
% Displays the certains bounding box of a specified frame. Used to display
% the reference of the ball. 
    hold on
    imshow(frame)
    rectangle('Position', [b_box(2,1), b_box(1,1), b_box(2,2)-b_box(2,1), b_box(1,2)-b_box(1,1)],  'EdgeColor', 'g');
end