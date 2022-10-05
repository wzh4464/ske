% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-05 15:53:15
% n = 200;
% testMat = eye(n);
% for i=1:randi(2*n)
%     testMat = testMat*swapijMat(randi(n),randi(n),n);
% end
% imshow(testMat)

datapath = matlab.project.rootProject().RootFolder + "/ELSDc/Dataset4_mydataset/";
filename = "043_0011";

% bad points id(30) = 45
elli = GenElli(datapath, filename, '.jpg');
