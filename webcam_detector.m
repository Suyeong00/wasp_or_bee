clear camera
%%

% Load the detector
detectorStruct = load('detector.mat');
detector = detectorStruct.detector;  % Adjust this line based on the actual field name

camera = webcam;
h = figure;

while ishandle(h)
    %% 카메라에서 객체 인식
    detected_object = get_detected_object(camera, detector);

    bboxes = detected_object.bboxes;
    labels = detected_object.labels;

    %% 인식된 객체가 없다면 continue
    if isempty(bboxes)
        continue;
    end
    
    %% 말벌의 중심 좌표 획득
    centerXY = get_wasp_center(labels, bboxes);

    if ~isempty(centerXY)
        disp('Detected wasp center coordinates:');
        disp(centerXY);
    end
end

clear camera;