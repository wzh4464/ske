% @Author: WU Zihan
% @Date:   2022-09-27 08:24:05
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-04 21:42:00
% n = 200;
% testMat = eye(n);
% for i=1:randi(2*n)
%     testMat = testMat*swapijMat(randi(n),randi(n),n);
% end
% imshow(testMat)

cf = frames{5};
nf = cf;
nf.dropSmallArcs();
nf