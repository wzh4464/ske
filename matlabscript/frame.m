% @Author: WU Zihan
% @Date:   2022-09-30 16:26:35
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-01 22:23:33
classdef frame
    %FRAME current status for caluculation
    %   Detailed explanation goes here

    properties
        points
        elli
        residue
        res_sum
        sourceimg
        group
    end

    methods

        function obj = frame(raw_arc)
            %FRAME Construct an instance of this class
            %   points and elli is enough to build the obj
%             if argtype == 'eldsc'
                num = length(raw_arc.id);
                obj.group = cell(num, 1);
                obj.elli = raw_arc.elli;
                obj.points = raw_arc.points;
                for i = 1:num
                    obj.group{i} = i;
                end

%             else 
%                 % ! from ind
%             end

            obj.sourceimg = raw_arc.sourceimg;
            new_num = size(obj.elli, 1);
            obj.residue = zeros(new_num, 1);

            for i = 1:new_num
                % obj.residue(i) = Residuals_ellipse(obj.points{i},obj.elli(i,:));
                for j = 1:length(obj.group{i})
                    obj.residue(i) = obj.residue(i) + Residuals_ellipse(raw_arc.points{obj.group{i}(j)}, obj.elli(i, :));
                end

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

    end
end