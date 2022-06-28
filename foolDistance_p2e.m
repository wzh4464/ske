function min = foolDistance_p2e(point,ellipse_point)
%point distance to ellipse
%   [x,y] point_set
min = inf;
for i = 1:size(ellipse_point)
    tmp = norm(point-ellipse_point(i,:));
    if tmp < min
        min = tmp;
    end
end
end