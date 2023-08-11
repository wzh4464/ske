% @Author: WU Zihan
% @Date:   2022-10-01 19:32:26
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-05 00:15:37
function newframe = coclusterFrame(cframe, k, tolerence)

    % This function takes a co-clustering frame and returns a new frame with the same points but with the ellipses fit to the points in each row and column replaced by a single ellipse fit to all the points in the row or column.
    %
    % Inputs:
    %   - cframe: a co-clustering frame
    %   - k: the number of clusters to use in k-means clustering
    %   - tolerence: the tolerence for the residual of the ellipse fit
    %
    % Outputs:
    %   - newframe: a new frame with the same points but with the ellipses fit to the points in each row and column replaced by a single ellipse fit to all the points in the row or column
    
    if ~exist('tolerence', 'var')
        % third parameter does not exist, so default it to 1.
        tolerence = 1;
    end


    [u,s,~]=svd(cframe.cor);
    [ind, ~, ~] = kmeans(u*s, k); 

    new_elli = zeros(k, 5);
    new_points = cell(k, 2);
    % fprintf("k = %d\n",k)
    for i = 1:k
        % group is that which arcs (in ell_matrix) are from class i
        group = find(ind == i);
        ngroup = ind == i;
        
        group_originLabel = cframe.index(group);
        ngroup_originLabel = cframe.index(ngroup);

        new_points{i, 1} = vertcat(cframe.points{ngroup, 1});
        new_points{i, 2} = vertcat(group);

        try

            new_elli(i, :) = fit_ellipse(new_points{i, 1}(:, 1), new_points{i, 1}(:, 2));
            r = Residuals_ellipse(new_points{i, 1}, new_elli(i, :));

            if r > tolerence
                [new_elli, new_points, new_group] = dealDropped(new_points, i, cframe, group, new_elli);

                % fprintf("i = %d\n", i)
                % fprintf("big tolenrce: %d\n", r)
            end

        catch
            [new_elli, new_points, new_group] = dealDropped(new_points, i, cframe, group, new_elli);
            % fprintf("i = %d\n", i)
            % fprintf("Not an ellipse.\n")
        end

        % 应该分组后检查error 然后观察分组是否合理, 避免新fit出现错误值
        % 还有可以label里不用bwskel, 而是用OUTPUT里和他重合的点 !!!
    end

    % remove empty cells
    tmp_cell_empty = cellfun(@isempty, new_points);
    new_points(tmp_cell_empty(:, 1), :) = [];

    % remove empty rows
    tmp_ma_empty = isnan(new_elli);
    new_elli(tmp_ma_empty(:, 1), :) = [];

    newframe = frame(new_elli, new_points(:, 1), new_points(:, 2), cframe.sourceimg, cframe.index);
end

% This function deals with dropped points in a co-clustering frame by removing them from the new_points cell array and setting the corresponding row in new_elli to NaN. It then adds the remaining points to a new cell array and appends the corresponding ellipses to new_elli. The updated new_points and new_elli are returned.
%
% Inputs:
%   - new_points: a cell array containing the points in the co-clustering frame
%   - i: the index of the dropped point
%   - frame: the co-clustering frame
%   - group: a vector containing the indices of the remaining points in the same row or column as the dropped point
%   - new_elli: a matrix containing the ellipses in the co-clustering frame
%
% Outputs:
%   - new_elli: the updated matrix of ellipses
%   - new_points: the updated cell array of points
function [new_elli, new_points, new_group] = dealDropped(new_points, i, frame, group, new_elli)
    wr_new_points = cell(length(group), 2);
    new_points{i, 1} = [];
    new_points{i, 2} = [];
    new_elli(i, :) = [nan, nan, nan, nan, nan];

    for j = 1:length(group)
        wr_new_points{j, 1} = frame.points{group(j), 1};
        wr_new_points{j, 2} = group(j);
        new_elli = [new_elli; frame.elli(group(j), :)];
    end

    new_points = [new_points; wr_new_points];
    fprintf("%d st arc dropped.\n", i);
    % new_group is group without the dropped arc
    new_group = group(group ~= i);
end
