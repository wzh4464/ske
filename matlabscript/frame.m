classdef frame
    %FRAME current status for caluculation
    %   Detailed explanation goes here

    properties
        points
        elli
        residue
    end

    methods
        function obj = frame(points,elli)
            %FRAME Construct an instance of this class
            %   points and elli is enough to build the obj
            obj.points = points;
            obj.elli = elli;
            new_num = size(obj.elli,1);
            obj.residue= zeros(new_num,1);
            for i = 1:new_num
                obj.residue(i) = Residuals_ellipse(obj.points{i,1},obj.elli(i,:));
            end
        end

        function showPoints(obj,arc_num,sourceimg)
            arcShow(arc_num,sourceimg,obj.points);
        end

        function showEllipse(obj,arc_num,sourceimg)
            drawEllipseandShow(obj.elli(arc_num,:)',sourceimg);
        end

    end
end

