% @Author: WU Zihan
% @Date:   2022-10-01 20:52:47
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-01 21:39:59
classdef rawArc
    %RAWARC elsdc results arranged here
    %   Detailed explanation goes here

    properties
        points
        elli
        id
        sourceimg
        cor
    end

    methods

        function obj = rawArc(datapath, filename)
            %RAWARC Construct an instance of this class
            obj.sourceimg = datapath + filename + ".pgm";
            out_ellipse = load(datapath + filename + "_out_ellipse.txt");
            output = out_ellipse(:, 6:10);
            out_num = size(output, 1);
            cor = zeros(out_num);

            for i = 1:out_num

                for j = 1:out_num
                    cor(i, j) = iou(output(i, :), output(j, :));
                end

            end
            obj.cor = cor;
            arc_names = out_ellipse(:, 1);

            % read points from pgm

            pgmname = datapath + filename + "_labels.pgm";
            pgmmat = transpose(getreg(pgmname));
            yxsize = readyxsize(pgmname);
            rows = yxsize(2);
            cols = yxsize(1);
            pgmmat = transpose(reshape(pgmmat, [cols, rows]));

            mat = zeros(rows, cols, out_num);
            mat = imbinarize(mat);

            for i = 1:out_num
                pureLabel = zeros(rows, cols);
                tmp_pgm = pgmmat == arc_names(i);
                pureLabel(tmp_pgm) = 1;
                mat(:, :, i) = bwskel(imbinarize(pureLabel), 'MinBranchLength', floor(sum(sum(tmp_pgm))/10));
            end

            arc_points = cell(out_num, 1);

            for i = 1:out_num
                [x, y] = find(mat(:, :, i) == 1);
                arc_points{i} = [x, y];
            end

            obj.points = arc_points;
            obj.elli = output;
            obj.id = arc_names;
        end

    end

end
