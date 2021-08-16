clear
%% 创建 figure, 并设置背景颜色
back_color = [0.15, 0.15, 0.15];
h_f = figure('Color', back_color);

%% 创建 axes
h_a = axes('Parent', h_f);
set(h_a, 'NextPlot', 'add'); % 相当于 hold on

%% 创建 plot
% 绘制正弦积分函数
fun = @(x)(sinc(x/pi));
x = linspace(-1, 4, 400);
y = zeros(1, length(x));

wc = pi; % 截止频率
td = 1;  % 时延
for i = 1:length(x)
    tmp = (x(i) - td)*wc;
    y(i) = integral(fun, 0, tmp)/pi + 0.5;
end
plot(x, y, 'LineStyle', '-', 'Color', [0, 1, 1], 'LineWidth', 1.5);

wc = 2*pi; % 增加截止频率
td = 1;    % 时延
for i = 1:length(x)
    tmp = (x(i) - td)*wc;
    y(i) = integral(fun, 0, tmp)/pi + 0.5;
end
plot(x, y, 'LineStyle', '-', 'Color', [0.39, 0.83, 0.07], 'LineWidth', 1.5);

% 其他标线
lcolor = [0.39, 0.83, 0.07];
plot([td, td], [0, 0.5], 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1.5)
plot([0, td], [0.5, 0.5], 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1.5)
plot([0, td+pi/wc], [1,1]*max(y), 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1)
plot([1,1]*(td+pi/wc), [0, max(y)], 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1)
plot([0, td-pi/wc], [1,1]*min(y), 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1)
plot([1,1]*(td-pi/wc), [0, min(y)], 'LineStyle', '--', 'Color', lcolor, 'LineWidth', 1)
plot([0,4], [1,1], 'LineStyle', '-.', 'Color', [1, 0, 1], 'LineWidth', 1);

% 设置坐标轴的范围
xlim([-1, 4]);
ylim([-0.3, 1.5]);

%% 绘制 arrow
param = struct('XLabel', '$t$', 'YLabel', '$s(t)$', 'OLabel', '$O$');
DrawAxisWithArrow(h_a, param);

%% 添加一些标注

% 在axes上的(0,1)左侧添加标注
fp = CoorFromAxis2Fig(h_a, [0,1]); % 将axes的坐标转化为figure上的坐标，下同
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 14);
FigPointLabel(fp, '1.0', 'west', param);

% 在axes上的(0,0.5)左侧添加标注
fp = CoorFromAxis2Fig(h_a, [0,0.5]);
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 14);
FigPointLabel(fp, '0.5', 'west', param);

% 在axes上的(td,0)下方添加标注
fp = CoorFromAxis2Fig(h_a, [td,0]);
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 14);
FigPointLabel(fp, '$t_d$', 'south', param);

% 在axes上的(td+pi/wc,0)下方添加标注
fp = CoorFromAxis2Fig(h_a, [td+pi/wc,0]);
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 12);
FigPointLabel(fp, '$t_d+\frac{\pi}{w_c}$', 'south', param);

% 在axes上的(td-pi/wc,0)下方添加标注
fp = CoorFromAxis2Fig(h_a, [td-pi/wc, min(y)]);
param = struct('Color', [0.8, 0.52, 0.98], 'FontSize', 12);
FigPointLabel(fp, '$t_d-\frac{\pi}{w_c}$', 'south', param);

%% 保存图像
if true
    img_name = SaveFig2Img(h_f, 'figures\demo03.png');
    fprintf('图像保存为: %s\n', img_name);
end
