% @Author: WU Zihan
% @Date:   2022-10-11 20:03:52
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-11 20:06:51
src = imread("resource/overlap.png");
gray = rgb2gray(src);
imwrite(src, "resource/overlap.pgm");