% @Author: WU Zihan
% @Date:   2022-10-02 19:11:45
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 19:52:23
function res = frameResGroup(preFrame, arcset)
    %frameResGroup - use postFrame's group to calculate residue of preFrame
    %
    % Syntax: resSum = frameResGroup(preFrame, arcset)
    %
    % To decide whethe new frame should be accept, line by line.

    res = 0;

    for j = 1:length(arcset)
        res = res + Residuals_ellipse(preFrame.points{arcset(j)}, preFrame.elli(arcset(j), :));
    end

end
