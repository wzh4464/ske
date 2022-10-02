% @Author: WU Zihan
% @Date:   2022-09-30 16:26:35
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:43:33
classdef frame < matlab.mixin.Copyable
    %FRAME current status for caluculation
    %   Detailed explanation goes here

    properties
        points
        elli
        residue
        res_sum
        sourceimg
        group
        ANum
        cor
    end

    methods

        function obj = frame(varargin)
            %FRAME Construct an instance of this class
            %   raw_arc, elli, points, ind

            if nargin == 1

                raw_arc = varargin{1};
                num = length(raw_arc.id);
                obj.group = cell(num, 1);
                obj.elli = raw_arc.elli;
                obj.points = raw_arc.points;
                obj.sourceimg = raw_arc.sourceimg;
                obj.cor = raw_arc.cor;

                for i = 1:num
                    obj.group{i} = i;
                end

            else

                if nargin == 4 % elli, points, group, sourceimg
                    obj.elli = varargin{1};
                    obj.points = varargin{2};
                    % group = varargin{4};
                    % num = max(ind);
                    obj.group = varargin{3};
                    % for i = 1:num
                    %     obj.group{i} = find(ind==i);
                    % end
                    obj.sourceimg = varargin{4};

                    out_num = size(obj.elli, 1);
                    obj.cor = zeros(out_num);

                    for i = 1:out_num

                        for j = 1:out_num
                            obj.cor(i, j) = iou(obj.elli(i, :), obj.elli(j, :));
                        end

                    end

                end % ! from ind

            end

            obj.ANum = size(obj.elli, 1);
            obj.residue = zeros(obj.ANum, 1);

            for i = 1:obj.ANum

                obj.residue(i) = Residuals_ellipse(obj.points{i}, obj.elli(i, :));

            end

            obj.res_sum = obj.resSum();

        end

        function showPoints(obj, arc_num)
            arcShow(arc_num, obj.sourceimg, obj.points);
        end

        function showEllipse(obj, arc_num)
            drawEllipseandShow(obj.elli(arc_num, :)', obj.sourceimg);
        end

        function res_sum = resSum(obj)
            %resSum
            %
            % Syntax: res_sum = resSum()
            %
            % calculate total error for this frame

            res_sum = sum(obj.residue);

        end

        %         function pointset = pointOfSet(obj, raw_arc, k)
        %             %pointOfSet - pointset of group k
        %             %
        %             % Syntax: pointset = pointOfSet(raw_arc,k)
        %             pointset = [];
        %
        %             for i = 1:length(group)
        %             end
        %
        %         end
        function comparePaE(obj, k)
            drawEllipseandShow(obj.elli(k, :)', obj.sourceimg);
            hold on
            scatter(obj.points{k}(:, 2), obj.points{k}(:, 1), 10, 'green', 'filled', 'square');
        end

        function showAllElli(obj)
            drawEllipseandShow(obj.elli', obj.sourceimg);
        end

    end

end
