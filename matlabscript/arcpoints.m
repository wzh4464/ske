function set = arcpoints(out_ellipse)
%  ARCPOINTS pixels for an arc
% 
% input: 1*12 matrix
% 
% output: points
a = out_ellipse(8);
b = out_ellipse(9);
x0 = out_ellipse(6);
y0 = out_ellipse(7);
theta = out_ellipse(10);
phi1 = out_ellipse(11);
phi2 = out_ellipse(12);
x1 = out_ellipse(2);
y1 = out_ellipse(3);
x2 = out_ellipse(4);
y2 = out_ellipse(5);
bigflag = 0;
set = [];
if (out_ellipse(13) == 1) || norm([x1,y1]-[x2,y2]) < 3
    for phi = 0:0.5:360
        phi_ = phi /180 * pi;
        x = x0 + a * cos(theta) * cos (phi_) - b * sin(theta) * sin(phi_);
        y = y0 + a * cos(theta) * sin (phi_) + b * sin(theta) * cos(phi_);
        set = [set;[round(x),round(y)]];
    end
else
for phi = 0:0.5:360
    phi_ = phi /180 * pi;
    x = x0 + a * cos(theta) * cos (phi_) - b * sin(theta) * sin(phi_);
    y = y0 + a * cos(theta) * sin (phi_) + b * sin(theta) * cos(phi_);
    flag = 0; 
    angle = atan2(y-y0,x-x0);
    for m = -1:1:1
        if ((phi1 > angle + m * 2 * pi) && (angle + m * 2 * pi > phi2)) || ((phi1 < angle + m * 2 * pi) && (angle + m * 2 * pi < phi2))
            flag = 1; % in good region
            set = [set;[round(x),round(y)]];
        end
    end
    if flag
        bigflag = 1; % in good region
    end
    if bigflag % in good region
        if flag == 0 % pass the good region
            break
        end
    end
end
end
set = unique(set,"rows");
end