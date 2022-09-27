function M = distanceMatrix(verboseEllipse,points,ellipse_point,len)
%generate distance Matrix
%   verboseEllipse n*13
num = size(verboseEllipse,1);
M = zeros(num,num);
for i = 1:num
    for j = 1:num
        M(i,j) = distance_arc(i,j,points,ellipse_point,len);
    end
end
end