% @Author: WU Zihan
% @Date:   2022-09-27 22:24:30
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:42:43
function arcShow(k, img, points)
    %ARCSHOW show arcpoints quickly
    %   k is out of out_num

    figure
    imshow(img);
    hold on
    scatter(points{k, 1}(:, 2), points{k, 1}(:, 1), 10, 'green', 'filled', 'square');
    hold off
end
