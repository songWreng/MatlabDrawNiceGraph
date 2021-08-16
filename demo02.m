clear
%% 设置fig背景为深色模式
back_color = [0.15, 0.15, 0.15];
h_f = figure('Color', back_color);

%% 绘制 sin
sin_axis = subplot(211);
x = linspace(-3*pi, 3*pi, 200);
y = sin(x);
plot(sin_axis, x, y, 'g-');
xlim([-3*pi, 3*pi]);
ylim([-1.2, 1.2]);
% 绘制坐标轴
param = struct('XLabel', '$x$', 'YLabel', '$\sin x$', 'OLabel', '$O$');
DrawAxisWithArrow(sin_axis, param);

%% 绘制 cos
cos_axis = subplot(212);
y2 = cos(x);
plot(cos_axis, x, y2, 'y-');
xlim([-3*pi, 3*pi]);
ylim([-1.2, 1.2]);
param = struct('XLabel', '$x$', 'YLabel', '$\cos x$', 'OLabel', '$O$');
DrawAxisWithArrow(cos_axis, param);

%% 保存为图像
if true
    img_name = SaveFig2Img(h_f, 'figures\demo02.png');
    fprintf('图像保存为: %s\n', img_name);
end