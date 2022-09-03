function d = Correlation(a,b,lambda)
if(~exist('lambda','var'))
    lambda = 500;  % 如果未出现该变量，则对其进行赋值
end
%     x = a;
%     x(3:4) = x(3:4);
%     x(5) = x(5);
%     y = b;
%     y(3:4) = y(3:4);
%     y(5) = y(5);
%     xx = x/norm(x);
%     yy = y/norm(y);
%     d = abs(dot(xx,yy));
    d = exp(-norm(a-b)/lambda);
end
    