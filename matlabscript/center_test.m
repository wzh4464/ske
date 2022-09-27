clc;
% 6.26 中心点聚类
clear
load("/home/wu/codes/ELSDc/out_ellipse.txt");
% tmp = out_ellipse(:,6:12);
% output = [out_ellipse(:,6:10),abs(out_ellipse(:,12)-out_ellipse(:,11))];
output = out_ellipse(:,6:7);
R=output;
for j = 2:10 % kmeans 的 k
    cluster = kmeans(R,j);
    figure;
    silhouette(R,cluster);
end