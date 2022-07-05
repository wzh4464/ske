%% loading
clc;
load("/home/wu/codes/ELSDc/out_ellipse.txt");
output = out_ellipse(:,6:10);
out_num = size(output,1);
cor = zeros(out_num);
for i = 1 : out_num
    for j = 1 : out_num
        cor(i,j) = Correlation(output(i,:),output(j,:));
    end
end

%% Yan's own word

[u,s,~]=svd(cor);
R = (u*s);
sums = NaN(1,50);
for j = 2:10 % kmeans 的 k
    [ind,~,sumd] = kmeans(R,j);
    [~,I]=sort(ind);
    newcor = cor(I,I);
    img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
    sums(j) = sum(sumd);
    tmp = zeros(j,5);
    for i = 1:size(output,1)
        tmp(ind(i),:) = output(i,:);
    end
end