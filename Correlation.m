function d = Correlation(a,b)
    x = a;
    x(3:4) = x(3:4);
    x(5) = x(5);
    y = b;
    y(3:4) = y(3:4);
    y(5) = y(5);
    xx = x/norm(x);
    yy = y/norm(y);
    d = abs(dot(xx,yy));
end
    