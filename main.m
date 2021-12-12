load ('hockeyarcpoints.txt','-ascii',arcpoints)
[sizex,~] = size(arcpoints);

arc = 0;
new_label = 0;

cellArc = {};
for i = 1 : sizex
    arc_label = arcpoints(i,1);
    if arc~=arc_label
        cellArc{arc} = F;
        arc = arc_label;
        new_label = new_label+1;
        F = [];
        k = 1;
    end
    F(k,1) = arcpoints(i,2);
    F(k,2) = arcpoints(i,3);
    F(k,3) = arcpoints(i,1);
    k = k + 1;
end