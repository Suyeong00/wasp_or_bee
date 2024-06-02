function [centerXY] = get_wasp_center(labels, bboxes)
    % 초기화
    my_table = zeros(0, 4); % 빈 행렬로 초기화
    
    % 'wasp' 레이블을 가진 바운딩 박스를 필터링
    for k = 1:length(labels)
        if labels(k) == 'wasp'
            my_table = [my_table; bboxes(k, :)];
        end
    end
    
    % 중심 좌표 계산
    if ~isempty(my_table)
        num_boxes = size(my_table, 1);
        centerXY = zeros(num_boxes, 2);
        
        for i = 1:num_boxes
            centerX = my_table(i, 1) + my_table(i, 3) / 2;
            centerY = my_table(i, 2) + my_table(i, 4) / 2;
            centerXY(i, :) = [centerX, centerY];
        end
    else
        centerXY = [];
    end
end
