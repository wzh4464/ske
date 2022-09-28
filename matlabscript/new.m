% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-09-28 21:55:25
%% svd

[u,s,~]=svd(cor);
R = (u*s^(1/2));

k = floor(out_num/2);
[ind,~,sumd] = kmeans(R,k);
[~,I]=sort(ind);
newcor = cor(I,I);

%% calculate erros
% sums = NaN(1,50);
% for j = 5:25 % kmeans 的 k
%     [ind,~,sumd] = kmeans(R,j);
%     [~,I]=sort(ind);
%     newcor = cor(I,I);
%     sums(j) = sum(sumd);
%     tmp = zeros(j,5);
%     for i = 1:size(output,1)
%         tmp(ind(i),:) = output(i,:);
%     end
% end
% plot(sums)

%%
    k = max(ind);
    new_elli = zeros(k,5);
    new_points = cell(k,2);
    for i = 1:k
        group = find(ind==i);
     
        for j= 1:length(group)
            new_points{i,1} = [new_points{i,1};arc_points{group(j),1}];
            new_points{i,2} = [new_points{i,2};group(j)];
        end
        new_elli(i,:)=fit_ellipse(new_points{i,1}(:,1),new_points{i,1}(:,2));
        % 应该分组后检查error 然后观察分组是否合理, 避免新fit出现错误值
        % 还有可以label里不用bwskel, 而是用OUTPUT里和他重合的点 !!!
    end
