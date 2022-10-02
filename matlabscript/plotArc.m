% @Author: WU Zihan
% @Date:   2022-09-27 22:24:30
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:44:27
function plotArc(arcpoints, ind, row, col)
    %plot arc points
    %   Arcpoints are cells
    % figure;
    hold on;

    for i = 1:length(ind)
        scatter(arcpoints{ind(i)}(:, 1), arcpoints{ind(i)}(:, 2), 5);
    end

    xlim([0 col])
    ylim([0 row])
end
