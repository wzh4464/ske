%% loading
clear;
clc;

datapath = "ELSDc/Dataset4_mydataset/";
filename = "666";

out_ellipse=load(datapath + filename + "_out_ellipse.txt");

% load("sim.mat","sim");
sourceimg = datapath + filename +".pgm";
img = imread(sourceimg);
output = out_ellipse(:,6:10);
out_num = size(output,1);
cor = zeros(out_num);
for i = 1 : out_num
    for j = 1 : out_num
        cor(i,j) = iou(output(i,:),output(j,:));
    end
end
% for i = 1 : out_num
%     out_ellipse(i,1) = i;
% end

% name of arcs
arc_names = out_ellipse(:,1);

%% read points from pgm

pgmname = datapath + filename + "_labels.pgm";
pgmmat = transpose(getreg(pgmname));
yxsize = readyxsize(pgmname);
rows = yxsize(2);
cols = yxsize(1);
max_label = pgmMaxLabel(pgmname); % 最大meaningful label for elli

pgmmat = transpose(reshape(pgmmat,[cols,rows]));


% figure
% imshow(sourceimg)
% figure
% imshow(pgmmat)

% arcpoints{i,1} 是点的集合, {i,2}label_meaningful
% arc_points = cell(max_label,2);
% for i=1:rows
%     for j=1:cols
%         if pgmmat(i,j)
%             arc_points{pgmmat(i,j),1}=[arc_points{pgmmat(i,j),1};i,j];
%         end
%     end
% end
% for i=1:max_label
%     arc_points{i,2} = size(arc_points{i,1},1);
% end

mat = zeros(rows,cols,out_num);
mat = imbinarize(mat);
for i=1:out_num
    pureLabel = zeros(rows,cols);
    pureLabel(pgmmat==arc_names(i)) = 1;
    mat(:,:,i) = bwskel(imbinarize(pureLabel));
end

arc_points = cell(out_num,2);

for i=1:out_num
    [x,y] = find(mat(:,:,i)==1);
    arc_points{i,1} = [x,y];
    arc_points{i,2} = arc_names(i);
end

resi = zeros(out_num,1);
for i = 1:out_num
    resi(i) = Residuals_ellipse(arc_points{i,1},output(i,:));
end

%% frame

frames = cell(1,10);
frames{1} = frame(arc_points, output);

%% Yan's own word

% [u,s,~]=svd(cor);
% R = (u*s);
% sums = NaN(1,50);
% for j = 2:10 % kmeans 的 k
%     [ind,~,sumd] = kmeans(R,j);
%     [~,I]=sort(ind);
%     newcor = cor(I,I);
%     img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
%     sums(j) = sum(sumd);
%     tmp = zeros(j,5);
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = output(i,:);
%     end
% end
