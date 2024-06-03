function return_motor_home()
    writePosition(servo_motor1, 0.5);
    pause(0.4);
    fprintf('Current motor x position came back!\n');
    writePosition(servo_motor2, 0.5);
    pause(0.4);
    fprintf('Current motor y position came back!\n');
end