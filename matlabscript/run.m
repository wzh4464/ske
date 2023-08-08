try
    mexall
    [out, pgm] = mexELSDc('../toPGM/666.pgm');
catch
    disp('mexELSDc failed')
end