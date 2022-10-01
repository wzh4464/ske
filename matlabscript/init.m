% @Author: WU Zihan
% @Date:   2022-10-01 17:14:22
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-01 21:18:41
%% loading
clear;
clc;

datapath = matlab.project.rootProject().RootFolder+"/ELSDc/Dataset4_mydataset/";
filename = "666";

arcs = rawArc(datapath, filename);
frames = cell(10,1);
frames{1} = frame(arcs);