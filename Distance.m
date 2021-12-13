function d = Distance(a,b)
    x = a;
    x(3:4) = x(3:4)/1000;
    x(5) = x(5)/1000000;
    y = b;
    y(3:4) = y(3:4)/1000;
    y(5) = y(5) /1000000;
    xx = x/norm(x);
    yy = y/norm(y);
    d = abs(dot(xx,yy));
end
    