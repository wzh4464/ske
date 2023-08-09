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
