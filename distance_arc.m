function d = distance_arc(i,j,points,ellipoints,len)
%distance for arcs
%   short to long
%   for now, short means angle short
% len(i) = arc(i,8) * arc(i,9) * (arc(i,12) - arc(i,11));
% len(j) = arc(j,8) * arc(j,9) * (arc(j,12) - arc(j,11));
if len(i)>len(j)
    %     tmp = arc(i,:);
    short = j;
    long = i;
else
    short = i;
    long = j;
end
short_set = points{short};
sum = 0;
for k = 1:size(short_set, 1)
    %     sum = sum + rosin_dist(short_set(k,:), arc(long,6:10)); % rosin ones
    sum = sum + foolDistance_p2e(short_set(k,:), ellipoints{long});
end
d = sum/size(short_set, 1);
end