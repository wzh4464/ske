%{
%File: /for_latex.m
%Created Date: Wednesday August 16th 2023
%Author: Hance Ng
%-----
%Last Modified: Wednesday, 16th August 2023 8:38:05 pm
%Modified By: the developer formerly known as Hance Ng at <wzh4464@gmail.com>
%-----
%HISTORY:
%Date      		By	Comments
%----------		---	---------------------------------------------------------
%
%16-08-232023	ABC	Draw ellipse, width.
%}

% make a 200*200 zero matrix
canvas_size = 2000;
canvas = zeros(canvas_size, canvas_size);
xcenter = canvas_size / 2;
ycenter = canvas_size / 2;

% draw an ellipse
a = canvas_size / 2.1;
b = canvas_size / 4.2;

for x = 1:canvas_size

    for y = 1:canvas_size
        [r, xy] = Residuals_ellipse([x, y], [ycenter, xcenter, b, a, 0]);

        if r <= 0.2
            canvas(x, y) = canvas(x, y) + 1;
        end

    end

end

% draw a landscape ellipse
for x = 1:canvas_size

    for y = 1:canvas_size
        [r, xy] = Residuals_ellipse([x, y], [ycenter, xcenter, a, b, 0]);

        if r <= 0.2
            canvas(x, y) = canvas(x, y) + 1;
        end

    end

end

% find canvas==2 and make it 0
canvas(canvas == 0) = 2;
canvas(canvas == 1) = 0;
canvas(canvas == 2) = 1;

imshow(canvas);

% save as pgm
imwrite(canvas, 'overlap.pgm');