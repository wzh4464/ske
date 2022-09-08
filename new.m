% @Author: WU Zihan
% @Date:   2022-06-26 14:42:14
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-07-04 20:43:01
%% loading
% clc;
% % clear all;
% % load("/home/wu/codes/cocluster_matlab/out_ellipse_666.txt");
% load("/home/wu/codes/ELSDc/out_ellipse.txt");
% % tmp = out_ellipse(:,6:12);
% % output = [out_ellipse(:,6:10),abs(out_ellipse(:,12)-out_ellipse(:,11))];
% output = out_ellipse(:,6:10);
% % drawEllipses(output',"666.jpg",0)
% % ind = cocluster()
% out_num = size(output,1);
% cor = zeros(out_num);
% for i = 1 : out_num
%     for j = 1 : out_num
%         cor(i,j) = Correlation(output(i,:),output(j,:));
%     end
% end

%% R decomposition
% [u,s,~]=svd(cor);
% R = u*s^(1/2);
% sums = NaN(1,50);
% for j = 2:10 % kmeans 的 k
%     [ind,~,sumd] = kmeans(R,j);
%     [~,I]=sort(ind);
%     newcor = cor(I,I);
%     img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
%     %     C(j)={M};
%     %     id(j)={ind};
%     sums(j) = sum(sumd);
%     disp(sums(j))
%     disp(j)
%     imwrite(img,"data/chess"+string(j)+'.jpg')
%     tmp = zeros(j,5);
%     cnt = zeros(j);
% %     % average: very wrong
% %     for i = 1:size(output,1)
% %         tmp(ind(i),:) = tmp(ind(i),:)+output(i,:);
% %         cnt(ind(i)) = cnt(ind(i)) + 1;
% %     end
% %     for i = 1:j
% %         tmp(i,:) = tmp(i,:)/cnt(i);
% %     end
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = output(i,:);
%     end
%     drawEllipses(tmp',"666.jpg",j)
% end
% plot(sums)

%% Yan's own word

[u,s,~]=svd(cor);
R = (u*s^(1/2));
% R=R(1:3,:);
sums = NaN(1,50);
for j = 10:4:60 % kmeans 的 k
    [ind,~,sumd] = kmeans(R,j);
    [~,I]=sort(ind);
    newcor = cor(I,I);
    img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
    %     C(j)={M};
    %     id(j)={ind};
    sums(j) = sum(sumd);
    %     disp(sums(j))
    %     disp(j)
    %     imwrite(img,"data/chess"+string(j)+'.jpg')
    tmp = zeros(j,5);
    %     cnt = zeros(j);
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
    drawEllipses(tmp',sourceimg,j)
end
plot(sums)

%% simulation to validate co-cluster
% j = 3;
% cor = sim;
% [u,s,~]=svd(cor);
% [ind,~,~] = kmeans(u*s,j);
% [~,I]=sort(ind);
% newcor = cor(I,I);
% img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
%     %     C(j)={M};
%     %     id(j)={ind};
% %     sums(j) = sum(sumd);
% %     disp(sums(j))
% %     disp(j)
% imwrite(img,"data/chess"+string(j)+'.jpg')
%     tmp = zeros(j,5);
%     cnt = zeros(j);
%     % average: very wrong
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = tmp(ind(i),:)+output(i,:);
%         cnt(ind(i)) = cnt(ind(i)) + 1;
%     end
%     for i = 1:j
%         tmp(i,:) = tmp(i,:)/cnt(i);
%     end
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = output(i,:);
%     end
%     drawEllipses(tmp',sourceimg,j)



%%
j = 10;
% R=u*s;
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
for i = 1:size(output,1)
    tmp(ind(i),:) = tmp(ind(i),:)+output(i,:);
    cnt(ind(i)) = cnt(ind(i)) + 1;
end
for i = 1:j
    tmp(i,:) = tmp(i,:)/cnt(i);
end
%%     figure
drawtemp = tmp([1,2,4,5,11,13,16,17,19,21,30,31,34,35,38,41,44],:);
drawEllipses(drawtemp',sourceimg ,j)


%% find group and draw
elligroup={};
good_group = [1,7,8];
w = zeros(out_num,1);

for i = good_group
    drawgroup = i;
    
    elligroup{i} = out_ellipse(ind==drawgroup,:);
    accum_elli = zeros(1,5);
    for k = 1:size(elligroup{i},1)
        w(elligroup{i}(k,1)) = abs(elligroup{i}(k,12)-elligroup{i}(k,11));
        accum_elli = accum_elli + w(elligroup{i}(k,1))*output(elligroup{i}(k,1),:);
    end
    accum_elli = accum_elli/sum(w);
    drawEllipses(accum_elli',sourceimg ,j);
end 



%% after j = 4
close all;
group_num = 4;
for i = 1:size(out_ellipse,1)
    point{i} = arcpoints(out_ellipse(i,:));
end

set=[];
for i = 1:size(out_ellipse,1)
    ellipse_point{i} = ellipsePoint(out_ellipse(i,6:10));
end

arc_len = [];
for i = 1:size(out_ellipse,1)
    arc_len(i) = out_ellipse(i,8) * out_ellipse(i,9) * mod(out_ellipse(i,12) - out_ellipse(i,11),2*pi);
    %     arc_len(j) = abs(out_ellipse(j,8) * out_ellipse(j,9) * (out_ellipse(j,12) - out_ellipse(j,11)));
end

DM = distanceMatrix(out_ellipse(:,:),point,ellipse_point,arc_len)

dm_group={};
for i = 1:group_num
    dm_group{i} = DM(group{i},group{i});
end

%%
group_num = j;
group={};
for i = 1:group_num
    group{i} = find(ind==i);
end

collection={};
for i = 1:group_num
    collection{i} =[];
    truecollection{i} =[];
    for x = 1:size(dm_group{i},1)
        for y = 1:size(dm_group{i},2)
            if dm_group{i}(x,y) > 0 && dm_group{i}(x,y) < 20
                if arc_len(group{i}(x)) < arc_len(group{i}(y))
                    collection{i} = [collection{i}, x];
                else
                    collection{i} = [collection{i}, y];
                end
            end
        end
    end
    collection{i} = unique(collection{i});
    %     newgroup{i} = group{i};
    for j = 1:length(collection{i})
        truecollection{i} =[truecollection{i},group{i}(collection{i}(j))];
        %         newgroup{i} = newgroup{i}(newgroup{i}~=group{i}(collection{i}(j)));
    end
    newgroup{i} = setdiff(group{i}, truecollection{i});
end

%% plot
src = imread("666.jpg");
[row,col,~]=size(src);
for i =1:out_num
    plotpoint{i} = [];
    plotpoint{i}(:,1)=point{i}(:,1);
    plotpoint{i}(:,2)=row - point{i}(:,2);
end
figure;
for i = 1:group_num
    plotArc(plotpoint,newgroup{i},row,col);
end

%%
turn1_arc=[];
for i = 1:group_num
    turn1_arc = [turn1_arc,newgroup{i}'];
end
%%
drawEllipses(output([7,2,3,4,24,25,27,5,10,16],:)','666.jpg',102);












