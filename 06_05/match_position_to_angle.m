function [xdegree, ydegree] = match_position_to_angle(xCenter, yCenter, middlepointx, middlepointy, distance, half_degree)
    % arctan로 각도 계산
    if xCenter < middlepointx
        xdegree = half_degree + atan((middlepointx-xCenter)/distance);
    else
        xdegree = half_degree - atan((xCenter-middlepointx)/distance);
    end
    xdegree = xdegree/pi;

    if yCenter < middlepointy
        ydegree = half_degree - atan((middlepointy-yCenter)/distance);
    else
        ydegree = half_degree + atan((yCenter-middlepointy)/distance);
    end
    ydegree = ydegree/pi;