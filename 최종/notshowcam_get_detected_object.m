function [detected_object] = notshowcam_get_detected_object(camera, detector)
    I = snapshot(camera);
    image(I)
    [bboxes, scores, labels] = detect(detector, I);
    
    detected_object.bboxes = bboxes;
    detected_object.labels = labels;
end
