function return_motor_home(servo_motor1,servo_motor2)
    writePosition(servo_motor1, 0.55);
    %pause(0.4);
    fprintf('Current motor x position came back!\n');
    writePosition(servo_motor2, 0.495);
    %pause(0.4);
    fprintf('Current motor y position came back!\n');
end