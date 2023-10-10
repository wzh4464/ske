% @Author: WU Zihan
% @Date:   2022-10-01 17:14:22
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-05 00:31:26
%% loading
clear;
clc;

% % set random seeds
% globalStream = RandStream('mlfg6331_64', 'NormalTransform', 'Polar');
% RandStream.setGlobalStream(globalStream);
% 
% % set source files
% datapath = matlab.project.rootProject().RootFolder + "/sourceimg/denseElli/";
% datapath = "../sourceimg/denseElli/pgm/";
datapath = "../ELSDc/Dataset2_CalibrationPatterns/images/ring3img3";
filename = "ring3img3";
sourceimg = datapath + filename + ".pgm";

% generate frame from elsdc
arcs = rawArc(datapath, filename);
frames = cell(5, 1);
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

%% svd

[u, s, ~] = svd(arcs.cor);
R = (u * s^(1/2));
% u = v
% s_v = diag(s);
% plot(s_v)
%% kmeans
k = 50;
frames{2} = coclusterFrame(frames{1}, k);
k = 50;
frames{3} = coclusterFrame(frames{2}, k);
k = 50;
frames{4} = coclusterFrame(frames{3}, k);
k = 25;
frames{5} = coclusterFrame(frames{4}, k);
frames{5}.dropSmallArcs(0.1);

drawEllipseandShow(frames{5}.elli', frames{5}.sourceimg);
%%
% kframes = cell(27,1);
% resi = zeros(27,1);
% for i = 27:-1:1
%     kframes{i} = coclusterFrame(frames{1},i,R);
%     resi(i) = kframes{i}.res_sum;
% end

% %%
% k = 5;
% for i = 1:k
%     kframes{k}.showEllipse(i,sourceimg);
% end

%% compare
% preFrame = frames{1};
% postFrame = frames{2};
% comp = zeros(length(postFrame.group), 2);
%
% for i = 1:length(postFrame.group)
%     comp(i, 1) = frameResGroup(preFrame, postFrame.group{i});
%     comp(i, 2) = postFrame.residue(i);
% end

%% show all comparations
% k = 5;
% for i = 1:frames{k}.ANum
%     frames{k}.comparePaE(i);
% end

% consider length weight
% if length is too short at last, drop it
