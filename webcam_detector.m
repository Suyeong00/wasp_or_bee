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
    
end

clear camera;
