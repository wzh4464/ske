% @Author: WU Zihan
% @Date:   2022-10-01 20:52:47
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-05 16:45:43
classdef rawArc
    %RAWARC elsdc results arranged here
    %   Detailed explanation goes here

    properties
        points
        elli
        id
        sourceimg
        cor
        label
    end

    methods

        function obj = rawArc(datapath, filename, postfix)
            %RAWARC Construct an instance of this class
            if ~exist('postfix', 'var')
                postfix = ".pgm";
            end
            obj.sourceimg = datapath + filename + postfix;
            % obj.sourceimg is a char
            obj.sourceimg = char(obj.sourceimg);
            % out_ellipse = load(datapath + filename + "_out_ellipse.txt");
            % output = out_ellipse(:, 6:10);
            
            [output, arc_names, pgmmat]=mexELSDc(obj.sourceimg);
            % obj.label is backwards of arc_names
            obj.label = zeros(max(arc_names), 1);
            obj.label(arc_names) = 1:numel(arc_names);
            
            % arc_names = out_ellipse(:, 1);
            out_num = size(output, 1);
            % read points from pgm

            % pgmname = datapath + filename + "_labels.pgm";
            % pgmmat = transpose(getreg(pgmname));
            rows = size(pgmmat,1);
            cols = size(pgmmat,2);

            pgmmax = max(max(pgmmat));
            pgmshow = double(pgmmat)/double(pgmmax);
            imshow(pgmshow);

            % pgmmat = transpose(reshape(pgmmat, [cols, rows]));

            mat = zeros(rows, cols, out_num);
            mat = imbinarize(mat);
            wrong_stack = [];

            for i = 1:out_num
                tmp_pgm = pgmmat == arc_names(i);
                mat(:, :, i) = bwskel(tmp_pgm, 'MinBranchLength', floor(sum(sum(tmp_pgm)) / 10));
                % the bwskel result may be null
                if sum(sum(mat(:, :, i))) == 0
                    wrong_stack = [wrong_stack, i];
                end

            end

            % deal with wrong_stack
            wrong_num = length(wrong_stack);
            out_num = out_num - wrong_num;
            mat(:, :, wrong_stack) = [];
            output(wrong_stack, :) = [];
            arc_names(wrong_stack) = [];

            arc_points = cell(out_num, 1);

            for i = 1:out_num
                [x, y] = find(mat(:, :, i) == 1);
                arc_points{i} = [x, y];
            end

            obj.points = arc_points;
            obj.elli = output;
            obj.id = arc_names;

            cor = zeros(out_num);

            for i = 1:out_num

                for j = 1:out_num
                    cor(i, j) = iou(output(i, 1:5), output(j, 1:5));
                end

            end

            obj.cor = cor;
            drawEllipseandShow(obj.elli', obj.sourceimg)
        end

    end

end
