%% clear all arduino
clear
clc
close all

%% load detector.mat
load('detector_0605.mat');

%% arduino objects
a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
servo_motor1 = servo(a, 'D5')
servo_motor2 = servo(a, 'D6')
%servo_motor1 = servo(a, 'D5', 'MinPulseDuration', 5.44e-4, 'MaxPulseDuration', 2.40e-3)

%% 지정된 값
% 모터 초기 상태: 각도 0
return_motor_home(servo_motor1, servo_motor2);
% 각도 리셋 상태: 0

angle_x = 0.5;
angle_y = 0.5;

%부저, 레이저 핀
buzzerPin = 'D3';
laserPin = 'D7';
% 딜레이 지정
xpointing_speed_delay = 0.01;
ypointing_speed_delay = 0.01;
xback_speed_delay = 0.01;
yback_speed_delay = 0.01;
lasertime = 0.04;
laserstoptime = 0.04;
buzzerdelay = 1.5;
% 픽셀을 cm로 치환
%inputsize: 가로 1920 pixel, 세로 1080 pixel, 거리: 30cm, 벌통 가로 길이: 24cm, 벌통 높이: 15cm
%벌통 높이 기준으로 비율: 1080/15 (pixel/cm)

real_distance = 30;
%distance_tuning; = 0;

box_height = 15;
half_degree = pi/2;
distance = real_distance * 1080/box_height;
middlepointx = 960;
middlepointy = 540;

%% 카메라 켜기
clear camera
camera = webcam;
h = figure;

time = 0;
while ishandle(h)
    %% 카메라에서 객체 인식
    detected_object = get_detected_object(camera, detector);
    bboxes = detected_object.bboxes;
    labels = detected_object.labels;
    time = time + 1;
    %% 인식된 객체가 없다면 continue
    if isempty(bboxes)
        % return_motor_home(servo_motor1, servo_motor2);
        % a.writeDigitalPin(laserPin, 1);
        % %pause(laserstoptime);
        % %모터 제자리로 이동
        % fprintf('default shoot\n');
        continue;
    end
        
    %% 말벌의 중심 좌표 획득
    centerXY = get_wasp_center(labels, bboxes);

    % if (time < 1)
    %     fprintf('%d\n', time);
    %     continue;
    % end;
    fprintf('0\n');
    %% 말벌이 한 마리 이상 있을 때
    if ~isempty(centerXY)
        %경보 1.5초 울림
        fprintf('5\n');
        playTone(a, buzzerPin, 2400, buzzerdelay);
        % 말벌이 두 마리 이상 있으면 첫번째 인식한 말벌만 취한다.
        idx = 1;
        wasp_pos = centerXY(idx,:);
        [xdegree, ydegree] = match_position_to_angle(wasp_pos(1), wasp_pos(2), middlepointx, middlepointy, distance, half_degree);
        % If 레이저가 말벌을 따라갔을 때
        if (abs(angle_x - xdegree) < (2/180)) & (abs(angle_y - ydegree) < (2/180))
            %레이저를 쏨
            fprintf('angle x = %d, xdegrer = %d\n', angle_x, xdegree);
            fprintf('angle y = %d, ydegrer = %d\n', angle_y, ydegree);
            a.writeDigitalPin(laserPin, 1);
            %pause(lasertime);
            fprintf('shoot\n');
        % 말벌을 따라가고 있을 때
        else 
            %레이저 안 쏨
            a.writeDigitalPin(laserPin, 0);
            %pause(laserstoptime);
            fprintf('2\n');
            %서보모터 작동
            [angle_x, angle_y] = rotate_motor(servo_motor1, servo_motor2, xdegree, ydegree, xpointing_speed_delay, ypointing_speed_delay, angle_x, angle_y);
            %레이저를 쏨
            a.writeDigitalPin(laserPin, 1);
            %pause(lasertime);
            fprintf('3\n');
        end
    %% 말벌이 없을 때
    else
        %레이저 안 쏨
        a.writeDigitalPin(laserPin, 0);
        %pause(laserstoptime);
        %모터 제자리로 이동
        return_motor_home(servo_motor1, servo_motor2);
        fprintf('4\n');
    end
    time = 0;
end

%%
clear camera;
clear servo_motor1 servo_motor2 a

