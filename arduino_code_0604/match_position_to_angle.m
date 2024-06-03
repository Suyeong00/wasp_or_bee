function [xdegree, ydegree] = match_position_to_angle(xCenter, yCenter, middlepointx, middlepointy, height)
    % arctan로 각도 계산
    if xCenter < middlepointx
        xdegree = half_degree - atan((middlepointx-xCenter)/height);
    else
        xdegree = half_degree + atan((xCenter-middlepointx)/height);
    end
    xdegree = xdegree/pi;

    if yCenter < middlepointy
        ydegree = half_degree - atan((middlepointy-yCenter)/height);
    else
        ydegree = half_degree + atan((yCenter-middlepointy)/height);
    end
    ydegree = ydegree/pi;