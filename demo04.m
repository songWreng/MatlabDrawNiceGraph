%% 绘制时移曲线
clear;
close all;
%% 设置fig背景为深色模式
back_color = [0.15, 0.15, 0.15];
h_f = figure('Color', back_color);

%% 创建axes
h_a = axes('Parent', h_f);
set(h_a, 'NextPlot', 'add'); % 相当于 hold on

%% 绘制曲线
t = linspace(0, 2*pi, 100);
t0 = pi*5/14;
y = 2*sin(t);

plot(h_a, t, y, 'LineStyle', '-', 'Color', [0.39, 0.83, 0.07], 'LineWidth', 1.5);
plot(h_a, t+t0, y, 'LineStyle', '-', 'Color', [0, 1, 1], 'LineWidth', 1.5);

% 圆
theta = linspace(0, 2*pi, 65);
r = 0.4;
rx = r*cos(theta);
ry = r*sin(theta);
plot(rx, ry, 'LineStyle', '-', 'Color', [1, 1, 1], 'LineWidth', 1.2);
plot(rx+t0, ry+2*sin(t0), 'LineStyle', '-', 'Color', [1, 1, 1], 'LineWidth', 1.2);
plot(rx+t0, ry, 'LineStyle', '-', 'Color', [1, 1, 1], 'LineWidth', 1.2);

% 这里是让 x 轴和 y 轴刻度一致，圆才会圆，这一句的位置必须设置再绘图plot之后，
% 调用 annotation (也就是一系列自定义的仓库之前), 这样由fig的坐标计算到axe的
% 坐标才准确
axis equal 
%% 绘制 arrow
param = struct('XLabel', '$t$', 'YLabel', '$f(t)$', 'OLabel', '$O$');
DrawAxisWithArrow(h_a, param);

%% 添加一些标注

% 两曲线时延的标注
fp = CoorFromAxis2Fig(h_a, [t0/2,-1]); % 将axes的坐标转化为figure上的坐标，下同
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 14);
FigPointLabel(fp, '$\tau$', 'south', param);
DrawLine(h_a, [0, -1], [t0, -1], struct('Type', 'doublearrow'));
DrawLine(h_a, [t0, 2*sin(t0)], [t0, -1], struct('Type', 'line', 'LineStyle', '--'));

% 绘制切线方向
dy = atan(2*cos(t0));
DrawLine(h_a, [0, 0], [r, 0], struct('Type', 'arrow', 'Color', [1,1,1]));
DrawLine(h_a, [t0, 2*sin(t0)], [r*cos(dy)+t0, r*sin(dy)+2*sin(t0)], struct('Type', 'arrow', 'Color', [1,1,1], 'LineWitdh', 0.8));
DrawLine(h_a, [t0, 0], [r+t0, 0], struct('Type', 'arrow', 'Color', [1, 1, 1]));

%% 保存图像
if true
    img_name = SaveFig2Img(h_f, 'figures\demo04.png');
    fprintf('图像保存为: %s\n', img_name);
end
