try
    mexall
    [out, pgm] = mexELSDc('../toPGM/666.pgm');
    pgmmax = max(max(pgm));
    pgm = double(pgm)/double(pgmmax);
    save('../toPGM/pgm666.mat', 'pgm');
catch
    disp('mexELSDc failed')
end