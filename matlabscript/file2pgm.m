function file2pgm(file, imgdatasetpath, pgmdatasetpath)
% file2pgm(file, imgdatasetpath, pgmdatasetpath)
% Converts a file to pgm format

if nargin < 2
    pgmdatasetpath = '../toPGM/';
    imgdatasetpath = '../sourceimg/';
end

src = imread(strcat(imgdatasetpath, file));

gray = rgb2gray(src);
% name is file name without extension (removing last point)
parts = strsplit(file, '.');
name = parts{1};

imwrite(gray, strcat(pgmdatasetpath, name, '.pgm'));

end