%% clear all arduino
clear
clc
close all

%% load detector.mat
load('detector.mat');

%% arduino objects
a = arduino('COM6', 'Uno', 'Libraries', 'Servo')
servo_motor1 = servo(a, 'D5');
servo_motor2 = servo(a, 'D6');
%servo_motor1 = servo(a, 'D3', 'MinPulseDuration', 5.44e-4, 'MaxPulseDuration', 2.40e-3);

%% 지정된 값
% 모터 초기 상태: 각도 0
reset_motor(servo_motor1, servo_motor2);
% 각도 리셋 상태: 0
angle_x = 0.;
angle_y = 0.;
%부저, 레이저 핀
buzzerPin = 'D3';
laserPin = 'D7';
% 딜레이 지정
xpointing_speed_delay = 0.04;
ypointing_speed_delay = 0.04;
xback_speed_delay = 0.04;
yback_speed_delay = 0.04;
lasertime = 0.04;
laserstoptime = 0.04;
buzzerdelay = 1.5;
% 픽셀을 cm로 치환
%inputsize: 416 pixel, 거리: 80cm, 벌통 가로 길이: 24cm, 벌통 높이: 48cm
%벌통 높이 기준으로 비율: 0.1cm/pixel
half_degree = 45;
height = 48;
middlepoint = 41.6;

%% 카메라 켜기
clear camera
camera = webcam;
h = figure;

while ishandle(h)
    %%%%%% 함수 필요 구간
    I = snapshot(camera);
    image(I)
    
    [bboxes,scores,labels] = detect(detector, I);
    showShape("rectangle", bboxes, 'Label', labels)
    drawnow

    if isempty(bboxes)
        continue;
    end
    my_table = [0, 0, 0, 0];
    for k=1:size(labels)
        if labels(k) == 'wasp'
            my_table = [my_table; bboxes(k,:)];
        end
    end
    if size(my_table) > 1
        bboxes = my_table;
    end

    if ~isempty(bboxes)
        for i = 2:size(bboxes, 1)
            centerX = bboxes(i, 1) + bboxes(i, 3) / 2;
            centerY = bboxes(i, 2) + bboxes(i, 4) / 2;
            
            % 중심 좌표 출력
            disp(['Box ', num2str(i), ': Center (X, Y) = (', num2str(centerX), ', ', num2str(centerY), ')']);
        end
    end
    %%%%%% 
    
    %% 말벌이 한 마리 이상 있을 때
    if size(centerXY,1) > 1
        %경보 1.5초 울림
        playTone(a, buzzerPin, 2400, buzzerdelay);
        % 말벌이 두 마리 이상 있으면 첫번째 인식한 말벌만 취한다.
        idx = 2;
        wasp_pos = centerXY(idx,:);
        [xdegree, ydegree] = match_position_to_angle(wasp_pos(1), wasp_pos(2));
        % If 레이저가 말벌을 따라갔을 때
        if abs(angle_x - xdegree) < 0.02 && abs(angle_y - ydegree) < 0.02
            %레이저를 쏨
            a.writeDigitalPin(laserPin, 1);
            pause(lasertime);
        % 말벌을 따라가고 있을 때
        else 
            %레이저 안 쏨
            a.writeDigitalPin(laserPin, 0);
            pause(laserstoptime);
            %서보모터 작동
            rotate_motor(servomotor1, servomotor2, xdegree, ydegree);
            %레이저를 쏨
            a.writeDigitalPin(laserPin, 1);
            pause(lasertime);
        end
    %% 말벌이 없을 때
    else
        %레이저 안 쏨
        a.writeDigitalPin(laserPin, 0);
        pause(laserstoptime);
        %모터 제자리로 이동
        return_motor_home(servo_motor1, servo_motor2);
    end
end

clear camera;
clear servo_motor1 servo_motor2 a

