% @Author: WU Zihan
% @Date:   2022-09-27 22:24:30
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:43:18
function set = ellipsePoint(ellipse)
    %Generate Ellipse Points
    %   input: 1*5
    set = [];
    x0 = ellipse(1);
    y0 = ellipse(2);
    a = ellipse(3);
    b = ellipse(4);
    theta = ellipse(5);

    for phi = 0:0.5:360
        phi_ = phi / 180 * pi;
        x = x0 + a * cos(theta) * cos (phi_) - b * sin(theta) * sin(phi_);
        y = y0 + a * cos(theta) * sin (phi_) + b * sin(theta) * cos(phi_);
        set = [set; [round(x), round(y)]];
    end

    set = unique(set, "rows");
end
