function movement = prediction(current_position, old_position)
    % The perfect motion model for a red ball. Moving down with velocity of
    % difference between the last and current position.
    y_cur = current_position(1);
    x_cur = current_position(2);
    y_old = old_position(1);
    x_old = old_position(2);
    
    %x_new = x_cur + x_cur-x_old;
    %y_new = x_cur + y_cur-y_old;

    x_new = x_cur - x_old;
    y_new = y_cur - y_old;

    movement = [y_new, x_new];
end