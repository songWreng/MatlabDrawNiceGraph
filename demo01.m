clear;

figure('color', [0.15, 0.15, 0.15]);
x = linspace(-3, 4, 100);
y = x.^2;
plot(x, y, 'Color', [0,1,1], 'LineWidth', 1.5);
% 调用 DrawAxisWithArrow 即可在当前坐标轴绘制带箭头坐标轴
param = struct('XLabel', '$x$', 'YLabel', '$y$', 'OLabel', '$O$');
DrawAxisWithArrow(gca, param);

%% 保存图像
if true
    img_name = SaveFig2Img(gcf, 'figures\demo01.png');
    fprintf('图像保存为: %s\n', img_name);
end