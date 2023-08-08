cd ../ELSDc/src

mex -g mexELSDc.c pgm.c svg.c elsdc.c gauss.c curve_grow.c polygon.c ring.c ellipse_fit.c rectangle.c iterator.c image.c lapack_wrapper.c misc.c -llapack

% mex mexELSDc.c pgm.c svg.c elsdc.c gauss.c curve_grow.c polygon.c ring.c ellipse_fit.c rectangle.c iterator.c image.c lapack_wrapper.c misc.c -llapack

% move mexELSDc.mex* to '../../matlabscript/'
!mv mexELSDc.mex* ../../matlabscript/

cd ../../matlabscript/