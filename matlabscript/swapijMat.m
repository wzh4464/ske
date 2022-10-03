% @Author: WU Zihan
% @Date:   2022-10-03 14:22:21
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-03 14:26:05
function swapmat = swapijMat(i,j,k)
    %SWAPIJMAT return swapijmat
    %   S^T*A*S
    %   dimension k
    swapmat = eye(k);
    swapmat(i,i)=0;
    swapmat(j,j)=0;
    swapmat(i,j)=1;
    swapmat(j,i)=1;

end
