% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-01 21:41:35
%% svd

[u,s,~]=svd(arcs.cor);
R = (u*s^(1/2));
% u = v
s_v = diag(s);
plot(s_v)
%% kmeans
frames{2} = coclusterFrame(frames,5,1,R);

%% 
kframes = cell(10,1);
resi = zeros(10,1);
for i = 1:16
    kframes{i} = coclusterFrame(frames,i,1,R);
    resi(i) = kframes{i}.res_sum;
end

%% 
k = 5;
for i = 1:k
    kframes{k}.showEllipse(i,sourceimg);
end
%% 
% tore = 100;
% cframe = kframes{8};
% for i = 1:k
%     if cframe.residue(i) < 100

%%
drawEllipseandShow(frames{1}.elli(4,:)',arcs.sourceimg);
hold on
scatter(frames{1}.points{4}(:,2),frames{1}.points{4}(:,1),10,'green','filled','square');









