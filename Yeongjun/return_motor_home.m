function return_motor_home()
    for angle_x = angle_x:1/180:0        
        writePosition(servo_motor1, angle_x);
        fprintf('Current motor x position is coming back...\n');
        pause(xback_speed_delay);
    end
    fprintf('Current motor x position came back!\n');
    for angle_y = angle_y:1/180:0        
        writePosition(servo_motor2, angle_y);
        fprintf('Current motor y position is coming back...\n');
        pause(yback_speed_delay);
    end
    fprintf('Current motor y position came back!\n');
end