clear camera
%%
camera = webcam;
h = figure;

while ishandle(h)
    I = snapshot(camera);
    image(I)
    
    [bboxes,scores,labels] = detect(detector, I);
    showShape("rectangle", bboxes, 'Label', labels)
    drawnow

    % 인식된 객체가 없으면 continue
    if isempty(bboxes)
        continue;
    end

    % 말벌 객체만 bboxes에 담음
    bboxes = extract_wasp_bboxes(bboxes, labels);

    % 말벌 객체가 없으면 continue
    if isempty(bboxes)
        continue;
    end

    for i = 2:size(bboxes, 1)
        centerX = bboxes(i, 1) + bboxes(i, 3) / 2;
        centerY = bboxes(i, 2) + bboxes(i, 4) / 2;
        % 중심 좌표 출력
        disp(['Box ', num2str(i), ': Center (X, Y) = (', num2str(centerX), ', ', num2str(centerY), ')']);
    end

end

clear camera;