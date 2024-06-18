% if in project
if exist('matlab.project.rootProject', 'file') == 2
    rootdir = matlab.project.rootProject().RootFolder;
else
    % rootdir = pwd/..
    rootdir = fileparts(pwd);
end

addpath(genpath(fullfile(rootdir, 'npy-matlab')))

video = readNPY(fullfile(rootdir, 'video.npy')); % (103, 250, 30)

% for first 5 frames (video(1:5, :, :))
for i = 1:5
    imshow(video(i, :, :), [])
    pause(0.1)
end
