function [angle_x1, angle_y1] = rotate_motor(servo_motor1, servo_motor2, xdegree, ydegree)
    writePosition(servo_motor1, xdegree);
    pause(0.01);
    writePosition(servo_motor2, ydegree);
    pause(0.01);
    angle_x1 = xdegree;
    angle_y1 = ydegree;
end