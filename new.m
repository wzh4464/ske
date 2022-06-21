clc;
% clear all;
load("/home/wu/codes/ELSDc/out_ellipse.txt");
% tmp = out_ellipse(:,6:12);
% output = [out_ellipse(:,6:10),abs(out_ellipse(:,12)-out_ellipse(:,11))];
output = out_ellipse(:,6:10);
drawEllipses(output',"666.jpg",0)
[~,out_num] = size(output');
cor = zeros(out_num);
for i = 1 : out_num
    for j = 1 : out_num
        cor(i,j) = Correlation(output(i,:),output(j,:));
    end
end
[u,s,~]=svd(cor);
R = u*s^(1/2);
% Sam = cor*u(:,1:5);
sums = NaN(1,50);
% C = cell(10,1);
% id = cell(10,1);
% output = output';
for j = 8:20 % kmeans 的 k
    [ind,~,sumd] = kmeans(R,j);
    [~,I]=sort(ind);
    newcor = cor(I,I);
    img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
    %     C(j)={M};
    %     id(j)={ind};
    sums(j) = sum(sumd);
    disp(sums(j))
    disp(j)
    imwrite(img,"data/chess"+string(j)+'.jpg')
    tmp = zeros(j,5);
    cnt = zeros(j);
%     % average: very wrong
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = tmp(ind(i),:)+output(i,:);
%         cnt(ind(i)) = cnt(ind(i)) + 1;
%     end
%     for i = 1:j
%         tmp(i,:) = tmp(i,:)/cnt(i);
%     end
    for i = 1:size(output,1)
        tmp(ind(i),:) = output(i,:);
    end
    drawEllipses(tmp',"666.jpg",j)
end
plot(sums)

% %%
% j = 8;
% [ind,~,sumd] = kmeans(R,j);
% [~,I]=sort(ind);
% newcor = cor(I,I);
% img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
% %     C(j)={M};
% %     id(j)={ind};
% sums(j) = sum(sumd);
% disp(sums(j))
% disp(j)
% imwrite(img,"data/chess"+string(j)+'.jpg')
% tmp = zeros(j,5);
% cnt = zeros(j);
% for i = 1:size(output,1)
%     tmp(ind(i),:) = tmp(ind(i),:)+output(i,:);
%     cnt(ind(i)) = cnt(ind(i)) + 1;
% end
% for i = 1:j
%     tmp(i,:) = tmp(i,:)/cnt(i);
% end
% %     figure
% drawEllipses(tmp',"666.jpg",j)