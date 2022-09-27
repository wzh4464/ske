function [] = drawEllipseandShow(ellipses_para,src)
figure

im=imread(src);
imshow(im);
hold on
th=0:pi/180:2*pi;
for i=1:size(ellipses_para,2)
    Semi_major= ellipses_para(3,i);
    Semi_minor= ellipses_para(4,i);
    x0= ellipses_para(1,i);
    y0= ellipses_para(2,i);
    Phi= ellipses_para(5,i);
    x=x0+Semi_major*cos(Phi)*cos(th)-Semi_minor*sin(Phi)*sin(th);
    y=y0+Semi_minor*cos(Phi)*sin(th)+Semi_major*sin(Phi)*cos(th);

    plot(x,y,'r', 'LineWidth',2);
end
% if ~isempty(im)
%     axis on; set(gca,'XTick',[],'YTick',[]);axis ij;axis equal;axis([0 size_im(2) 0 size_im(1)]);
% end
% saveas(gcf,'data/elli'+string(k)+'.jpg');
hold off
end
