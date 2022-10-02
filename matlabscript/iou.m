% @Author: WU Zihan
% @Date:   2022-09-27 22:24:30
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:44:02
function iou = iou(elli1, elli2)
    %IOU calculate iou of two ellipses
    %   1:5 x0 y0 a b phi
    data = zeros(2, 5);
    data(1, :) = elli1;
    data(2, :) = elli2;

    % rec (2:4:2)
    % x y
    % 1 2 3 4
    % 1 2

    % phi 顺时针旋转
    rec = zeros(2:4:2);

    for i = 1:2
        rotatemt = [cos(data(i, 5)), -sin(data(i, 5)); sin(data(i, 5)), cos(data(i, 5))];
        rec(:, 1, i) = [rotatemt, data(i, 1:2)'] * [data(i, 3:4)'; 1];
        rec(:, 2, i) = [rotatemt, data(i, 1:2)'] * [diag([-1, 1]) * data(i, 3:4)'; 1];
        rec(:, 3, i) = [rotatemt, data(i, 1:2)'] * [diag([-1, -1]) * data(i, 3:4)'; 1];
        rec(:, 4, i) = [rotatemt, data(i, 1:2)'] * [diag([1, -1]) * data(i, 3:4)'; 1];
    end

    rect1 = polyshape(rec(1, :, 1)', rec(2, :, 1)');
    rect2 = polyshape(rec(1, :, 2)', rec(2, :, 2)');

    in = intersect(rect1, rect2);
    un = union(rect1, rect2);

    iou = in.area / un.area;
end
