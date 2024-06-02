function [detected_object] = get_detected_object(camera, detector)
    I = snapshot(camera);
    image(I)
        
    [bboxes, labels] = detect(detector, I);
    showShape("rectangle", bboxes, 'Label', labels)
    drawnow
    
    detected_object.bboxes = bboxes;
    detected_object.labels = labels;
end
