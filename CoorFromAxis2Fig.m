function [fp] = CoorFromAxis2Fig(h_axi, ap)
%CoorFromAxis2Fig - 将点在 axis 的坐标转换为该点在 figure 上的坐标
%
% Syntax: [fp] = CoorFromAxis2Fig(h_axi, ap)
% 
% Input: h_axi 坐标轴句柄
%        ap 点在h_axi上的坐标
%
% Output:
%    fp 该点在figure上的坐标

x_range = get(h_axi, 'XLim'); % axis的x轴范围
y_range = get(h_axi, 'YLim'); % axis的y轴范围
rec = get(h_axi, 'Position'); % axis在fig的坐标(x,y,w,h)
fp(1) = (ap(1)-x_range(1))*rec(3) / (x_range(2)-x_range(1)) + rec(1);
fp(2) = (ap(2)-y_range(1))*rec(4) / (y_range(2)-y_range(1)) + rec(2);

end

