% @Author: WU Zihan
% @Date:   2022-10-01 17:14:22
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-02 22:43:57
%% loading
clear;
clc;

datapath = matlab.project.rootProject().RootFolder + "/ELSDc/Dataset4_mydataset/";
filename = "666";

arcs = rawArc(datapath, filename);
frames = cell(10, 1);
frames{1} = frame(arcs);

%% ? need refit
% tor = 1
% for i = 1:frames{1}.ANum

% testframe = copy(frames{1});
%
% for i=1:testframe.ANum
%     try
%         testframe.elli(i,:)=fit_ellipse(testframe.points{i}(:,1),testframe.points{i}(:,2));
%     catch err
%
%         % if error, which means refitting doesn give an ellipse, then
%         % retain those from elsdc
%
% %         testframe.elli(i,:)= [nan,nan,nan,nan,nan];
%     end
% end
%
% testframe = frame(arcs,testframe.elli,testframe.points,testframe.group);
% disp(find(testframe.residue-frames{1}.residue < 0));
% a = testframe.residue(testframe.residue-frames{1}.residue < 0);
% b = frames{1}.residue(testframe.residue-frames{1}.residue < 0);
