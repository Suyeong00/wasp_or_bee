function [angle_x, angle_y] = rotate_motor(servo_motor1, servo_motor2, xdegree, ydegree, xpointing_speed_delay, ypointing_speed_delay)
% 레이저가 따라감 x축
    
    for angle_x = 0:1/180:xdegree                %xdegree: 최대 1 (180도)
        writePosition(servo_motor1, angle_x);
        current_pos_x = readPosition(servo_motor1);
        current_pos_x = current_pos_x*180;
        fprintf('Current motor x position is %d degrees\n', current_pos_x);
        pause(xpointing_speed_delay);
    end
    % 레이저가 따라감 y축
    for angle_y = 0:1/180:ydegree                %ydegree: 최대 1 (180도)
        writePosition(servo_motor2, angle_y);
        current_pos_y = readPosition(servo_motor2);
        current_pos_y = current_pos_y*180;
        fprintf('Current motor y position is %d degrees\n', current_pos_y);
        pause(ypointing_speed_delay);
    end
end