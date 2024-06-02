function reset_motor(servo_motor1, servo_motor2)
    writePosition(servo_motor1, 0);
    pause(0.04);
    writePosition(servo_motor2, 0);
    pause(0.04);
end