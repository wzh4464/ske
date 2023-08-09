%% mex and run
try
    mexall
    [out,label, pgm] = mexELSDc('../toPGM/666.pgm');
    pgmmax = max(max(pgm));
    pgmshow = double(pgm)/double(pgmmax);
    save('../toPGM/pgm666.mat', 'pgm');
    imshow(pgmshow);
catch
    disp('mexELSDc failed')
end

%% test

% count different numbers in pgm
num = unique(pgm);

%% draw a ellipse and save as a pgm

% draw a ellipse
[xx,yy] = meshgrid(1:1000,1:1000);
ellipse = (xx-500).^2/500^2 + (yy-500).^2/250^2 <= 1;
ellipse = ellipse*255;
imshow(ellipse);

% save as a pgm
fid = fopen('ellipse.pgm','w');
fprintf(fid,'P5\n');
fprintf(fid,'%d %d\n',size(ellipse,2),size(ellipse,1));
fprintf(fid,'255\n');
fwrite(fid,ellipse','uint8');
fclose(fid);
