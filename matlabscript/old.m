sourceImg = imread('im9933.jpg');
gray = rgb2gray(sourceImg)
imshow(sourceImg)
[rows, cols] = size(gray)
disp('source_success')

arcpoints = load ('im9933arcpoints.txt','-ascii');
[arcpointsizex,~] = size(arcpoints);
arc = 0;
new_label = 0;

cellArc = {};
for i = 1 : arcpointsizex
    arc_label = arcpoints(i,1);
    if arc~=arc_label
        if arc > 0
            cellArc{new_label} = H;
        end
        arc = arc_label;
        new_label = new_label+1;
        
        H = [];
        k = 1;
    end
    H(k,1) = arcpoints(i,2)+1;
    H(k,2) = arcpoints(i,3)+1;
    H(k,3) = arcpoints(i,1);
    k = k + 1;
end
disp('success_1')
% Successfully saved arcs to cellArc
% coordinate +1, +1

[~, arc_num] = size(cellArc);
thinArc = cell(arc_num,1);
sol = zeros(5,arc_num);
for i = 1 : arc_num
    [point_num,~] = size(cellArc{i});
    img = full(sparse(cellArc{i}(:,1),cellArc{i}(:,2),ones(point_num,1)));
    [thinArc{i}(:,1),thinArc{i}(:,2), ~ ] = find(bwskel(logical(img)));
    [thin_num,~] = size(thinArc{i});
    F = zeros(point_num,5);
    G = zeros(point_num,1);
    for j = 1 : thin_num
        F(j,1) = thinArc{i}(j,1)^2 / rows^2;
        F(j,2) = thinArc{i}(j,1) * thinArc{i}(j,2) / (cols * rows);
        F(j,3) = thinArc{i}(j,2)^2 / (cols ^ 2);
        F(j,4) = thinArc{i}(j,1) / (rows);
        F(j,5) = thinArc{i}(j,2) / cols;
        G(j) = 1; % 可优化
    end
    sol(:,i) = F\G;
end
disp('success_2')
% thin Arc Done
% sol done
% F,G is transformed 1/sizex, 1/sizey

% output = sol(:,sol(1,:).^2-4.*sol(2,:)<0);
output = sol;
% change output to sol
[~,out_num] = size(output);
cor = zeros(out_num);
for i = 1 : out_num
    for j = 1 : out_num
        cor(i,j) = Correlation(output(:,i),output(:,j));
    end
end
[u,~,~]=svd(cor);
Sam = cor*u(:,1:5);
sums = NaN(1,50);
C = cell(10,1);
id = cell(10,1);

for j = 1:5 % kmeans 的 k
[ind,M,sumd] = kmeans(Sam,j);
[~,I]=sort(ind);
newcor = cor(I,I);
img=mat2gray(newcor);%将数值矩阵X转换为灰度图像
C(j)={M};
id(j)={ind};
sums(j) = sum(sumd);
disp(sums(j))
disp(j)
figure,imshow(img);
end
plot(sums) % 误差图 k = 4

k = 2;
group = id{k};
cocl = zeros(out_num,k);
for i = 1 : k
    [y,z] = find(group == i);
    f = full(sparse(y,z,1));
    [x,~] = size(f);
    cocl(1:x,i) = f;
end
conum = zeros(1,k);
for i = 1 : k
    conum(i) = sum(cocl(:,i));
end
disp('success_3')
% construct group matrix
% k columns in matrix cocl, each column tells us which arc belongs to
% which ellipse

output * cocl
cocl
conum

s = [];
for i = 1 : arc_num
    s = [s;thinArc{i}];
end
S = sparse(s(:,1),s(:,2),1);
imshow(full(S))
% gather all thin arc points

% draw cocl (sel) (sel for select)
% sel = 5;

% mkdir('im9933')
for sel = 1 : k
    s = [];
    for i = 1 : out_num
        if cocl(i,sel)>0
            s = [s;thinArc{i}];
        end
    end
    S = sparse(s(:,1),s(:,2),1);
    figure,imshow(full(S))
end

