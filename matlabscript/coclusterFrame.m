% @Author: WU Zihan
% @Date:   2022-10-01 19:32:26
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 11:47:14
function newframe = coclusterFrame(frames, k, ptr, R, arcs)
% k is k means argument
% ptr is source frame
[ind,~,~] = kmeans(R,k);
% [~,I]=sort(ind);
% newcor = cor(I,I);
% k = max(ind);
new_elli = zeros(k,5);
new_points = cell(k,2);
for i = 1:k
    group = find(ind==i);
    try
        for j= 1:length(group)
            new_points{i,1} = [new_points{i,1};frames{ptr}.points{group(j),1}];
            new_points{i,2} = [new_points{i,2};group(j)];
        end
        new_elli(i,:)=fit_ellipse(new_points{i,1}(:,1),new_points{i,1}(:,2));
    catch err
        wr_new_points = cell(length(group),2);
        new_elli(i,:)=[nan,nan,nan,nan,nan];
        new_points{i,1} = [];
        new_points{i,2} = [];
        for j= 1:length(group)
            wr_new_points{j,1} = frames{ptr}.points{group(j),1};
            wr_new_points{j,2} = group(j);
            new_elli = [new_elli;frames{ptr}.elli(group(j),:)];
        end
        new_points = [new_points;wr_new_points];
    end
    % 应该分组后检查error 然后观察分组是否合理, 避免新fit出现错误值
    % 还有可以label里不用bwskel, 而是用OUTPUT里和他重合的点 !!!
end
tmp_cell_empty = cellfun(@isempty,new_points);
new_points(tmp_cell_empty(:,1),:)=[];

tmp_ma_empty = isnan(new_elli);
new_elli(tmp_ma_empty(:,1),:)=[];

newframe = frame(arcs, new_elli, {new_points{:,1}}, {new_points{:,2}});
end