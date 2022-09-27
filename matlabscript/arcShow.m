function arcShow(k,img,points)
%ARCSHOW show arcpoints quickly
%   k is out of out_num
if ~exist("img",'var')
    img = imread(sourceimg);
end
if ~exist("points",'var')
    points = arc_points;
end
figure
imshow(img);
hold on
scatter(points{k,1}(:,2),points{k,1}(:,1),10,'green','filled','square');
hold off

end

