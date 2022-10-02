% @Author: WU Zihan
% @Date:   2022-09-29 22:59:36
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:45:03
function res_error = residueInd(arc_points, ind)
    %residueInd - calculate error with certain kmeans result
    %
    % Syntax: res_error = residueInd(arc_points, ind)
    %
    % Long description
    k = max(ind);
    new_elli = zeros(k, 5);
    new_points = cell(k, 2);

    for i = 1:k
        group = find(ind == i);
    end

    %    Residuals_ellipse(arc_points{i,1},)

end
