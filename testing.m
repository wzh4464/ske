n = 19;
a = out_ellipse(n, 8);
b = out_ellipse(n, 9);
x0 = out_ellipse(n, 6);
y0 = out_ellipse(n, 7);
theta = out_ellipse(n, 10);
phi1 = out_ellipse(n, 11);
phi2 = out_ellipse(n, 12);
x1 = out_ellipse(n, 2);
y1 = out_ellipse(n, 3);
x2 = out_ellipse(n, 4);
y2 = out_ellipse(n, 5);

rosin_dist([x1,y1],[x0,y0,a,b,theta])
% atan2((y1-y0),(x1-x0)) + 2 * pi
% atan2((y2-y0),(x2-x0)) + 2 * pi
% x0 + a * cos(theta) * cos (phi1) + b * sin(theta) * sin(phi1)

set = arcpoints(out_ellipse(9,:));%arc points
for i = 1:size(out_ellipse,1)
    point{i} = arcpoints(out_ellipse(i,:));
end

for i = 1:size(out_ellipse,1)
    for phi = 0:0.5:360
        phi_ = phi /180 * pi;
        x = x0 + a * cos(theta) * cos (phi_) - b * sin(theta) * sin(phi_);
        y = y0 + a * cos(theta) * sin (phi_) + b * sin(theta) * cos(phi_);
        set = [set;[round(x),round(y)]];
    end
    ellipse_point{i} = ellipsePoint(out_ellipse(i,6:10));
end


%
DM = distanceMatrix(out_ellipse(:,:),point,ellipse_point,arc_len)

group=[1,3,7,8,19,23];
dm = DM(group,group)
%%
DM