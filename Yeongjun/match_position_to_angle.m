function [xdegree, ydegree] = match_position_to_angle(xCenter, yCenter)
    % arctan로 각도 계산
    if xCenter < middlepoint
        xdegree = half_degree - atan((middlepoint-xCenter)/height);
    else
        xdegree = half_degree + atan((xCenter-middlepoint)/height);
    end
    xdegree = xdegree/pi;

    if yCenter < middlepoint
        ydegree = half_degree - atan((middlepoint-yCenter)/height);
    else
        ydegree = half_degree + atan((yCenter-middlepoint)/height);
    end
    ydegree = ydegree/pi;