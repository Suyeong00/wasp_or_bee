function [xdegree, ydegree] = match_position_to_angle(xCenter, yCenter, middlepointx, middlepointy, distance, half_degreex, half_degreey)
    % arctan로 각도 계산
    if xCenter < middlepointx
        xdegree = half_degreex + atan((middlepointx-xCenter)/distance);
    else
        xdegree = half_degreex - atan((xCenter-middlepointx)/distance);
    end
    xdegree = xdegree/pi;

    if yCenter < middlepointy
        ydegree = half_degreey - atan((middlepointy-yCenter)/distance);
    else
        ydegree = half_degreey + atan((yCenter-middlepointy)/distance);
    end
    ydegree = ydegree/pi;