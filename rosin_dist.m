function distance = rosin_dist(point ,ellipse)
%rosin_dist point to ellipse
%   Detailed from ring.c
%   if on, approximately < 1
%   input: 1*5 matrix
  xtmp = point(1) - ellipse(1);
  ytmp = point(2) - ellipse(2);
  ae2  = ellipse(3) * ellipse(3);
  be2  = ellipse(4) * ellipse(4);
  fe2 = ae2 - be2;
  xp = xtmp * cos(-ellipse(5)) - ytmp * sin(-ellipse(5));
  yp = xtmp * sin(-ellipse(5)) + ytmp * cos(-ellipse(5));
  xp2 = xp * xp;
  yp2 = yp * yp;
  delta = (xp2 + yp2 + fe2) * (xp2 + yp2 + fe2) - 4 * xp2 * fe2;
  A = (xp2 + yp2 + fe2 - sqrt(delta))/2.0; 
  ah = sqrt(A);
  bh2 = fe2 - A;
  term = (A * be2 + ae2 * bh2);
  xx = ah * sqrt( ae2 * (be2 + bh2) / term );
  yy = ellipse(4) * sqrt( bh2 * (ae2 - A) / term );
  d = zeros(1,4);
  d(4) = norm( [xp, yp] - [xx, yy]);
  d(1) = norm( [xp, yp] - [xx, -yy]);
  d(2) = norm( [xp, yp] - [-xx, yy]);
  d(3) = norm( [xp, yp] - [-xx, -yy]);
  distance = min(d);
end