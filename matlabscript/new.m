%% svd

[u,s,~]=svd(cor);
R = (u*s^(1/2));

k = floor(out_num/2);
[ind,~,sumd] = kmeans(R,k);
[~,I]=sort(ind);
newcor = cor(I,I);

%%
sums = NaN(1,50);
for j = 5:25 % kmeans 的 k
    [ind,~,sumd] = kmeans(R,j);
    [~,I]=sort(ind);
    newcor = cor(I,I);
%     img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
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
%     drawEllipses(tmp',sourceimg,j)
end
plot(sums)