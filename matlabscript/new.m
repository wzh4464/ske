% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-11 20:21:11
% n = 200;
% testMat = eye(n);
% for i=1:randi(2*n)
%     testMat = testMat*swapijMat(randi(n),randi(n),n);
% end
% imshow(testMat)

datapath = matlab.project.rootProject().RootFolder + "/ELSDc/Dataset4_mydataset/";
% filename = "043_0011";
filename = "overlap";

% bad points id(30) = 45
[elli,framecl] = GenElli(datapath, filename, '.pgm');
%%
arcs = rawArc(datapath, filename, '.pgm');
cframe = frame(arcs);