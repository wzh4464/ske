% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:44:16
%% svd

[u, s, ~] = svd(arcs.cor);
R = (u * s^(1/2));
% u = v
% s_v = diag(s);
% plot(s_v)
%% kmeans
k = 10;
frames{2} = coclusterFrame(frames{1}, 10, R);

%%
% kframes = cell(10,1);
% resi = zeros(10,1);
% for i = 1:16
%     kframes{i} = coclusterFrame(frames,i,1,R);
%     resi(i) = kframes{i}.res_sum;
% end

% %%
% k = 5;
% for i = 1:k
%     kframes{k}.showEllipse(i,sourceimg);
% end

%% compare
preFrame = frames{1};
postFrame = frames{2};
comp = zeros(length(postFrame.group), 2);

for i = 1:length(postFrame.group)
    comp(i, 1) = frameResGroup(preFrame, postFrame.group{i});
    comp(i, 2) = postFrame.residue(i);
end

%%
for i = 1:frames{2}.ANum
    frames{2}.comparePaE(i);
end

% 13 bad
% consider length weight
