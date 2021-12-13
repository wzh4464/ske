arcpoints = load ('hockeyarcpoints.txt','-ascii');
[sizex,~] = size(arcpoints);

arc = 0;
new_label = 0;

cellArc = {};
for i = 1 : sizex
    arc_label = arcpoints(i,1);
    if arc~=arc_label
        if arc > 0
            cellArc{new_label} = F;
        end
        arc = arc_label;
        new_label = new_label+1;
        F = [];
        k = 1;
    end
    F(k,1) = arcpoints(i,2)+1;
    F(k,2) = arcpoints(i,3)+1;
    F(k,3) = arcpoints(i,1);
    k = k + 1;
end
% Successfully saved arcs to cellArc
% coordinate +1, +1

[~, arc_num] = size(cellArc);
thinArc = cell(arc_num,1)
for i = 1 : arc_num
    [point_num,~] = size(cellArc{i});
    img = full(sparse(cellArc{i}(:,1),cellArc{i}(:,2),ones(point_num,1)));
    [thinArc{i}(:,1),thinArc{i}(:,2),thinArc{i}(:,3)] = find(bwskel(logical(img)));
end
% thin Arc Done
