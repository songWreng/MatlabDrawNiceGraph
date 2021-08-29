function [xarrow, yarrow] = DrawAxisWithArrow(h_axi, varargin)
%DrawAxisWithArrow - 绘制带箭头的坐标轴
%
% Syntax: [xarrow, yarrow] = DrawAxisWithArrow(h_axi[, param])
%
% Input: h_axi 坐标轴句柄
%        param 可选参数，要求输入参数为一个结构体，成员如下：
%               Color 坐标轴的颜色
%               HeadWidth 箭头大小
%               XLabel x轴的标签(在箭头上方)
%               YLabel y轴的标签(在箭头右方)
%               Olabel 原点的标签(两坐标轴交点的左下角)
%               XyVisible 可选值为x,y,xy(默认), 表示可视化的轴
%               若结构体未包含某项成员，则使用默认值               
%
% Output: xarrow x坐标轴对象
%         yarrow y坐标轴对象
    
%% 输入参数处理
n = length(varargin);
if n == 0
    arrow_color = [0.7, 0.62, 1]; % arrow 的默认颜色
    head_width = 6; % 箭头的默认大小
    xy_visible = 'xy'; % 显示x轴和y轴
    xlabel_str = ''; % x 轴的标签
    ylabel_str = ''; % y 轴的标签
    olabel_str = ''; % x 轴与y轴交点的标签
elseif n == 1
    % 坐标轴颜色
    if isfield(varargin{1}, 'Color')
        arrow_color = varargin{1}.Color;
    else
        arrow_color = [0.7, 0.62, 1];
    end
    % 箭头大小
    if isfield(varargin{1}, 'HeadWidth')
        head_width = varargin{1}.HeadWidth;
    else
        head_width = 6;
    end
    % x轴标签
    if isfield(varargin{1}, 'XLabel')
        xlabel_str = varargin{1}.XLabel;
    else
        xlabel_str = '';
    end
    % y轴标签
    if isfield(varargin{1}, 'YLabel')
        ylabel_str = varargin{1}.YLabel;
    else
        ylabel_str = '';
    end
    % 原点标签
    if isfield(varargin{1}, 'OLabel')
        olabel_str = varargin{1}.OLabel;
    else
        olabel_str = '';
    end
    % 显示的坐标轴
    if isfield(varargin{1}, 'XyVisible')
        xy_visible = varargin{1}.XyVisible;
    else
        xy_visible = 'xy';
    end
else
    error('DrawAxisWithArrow: 输入参数太多');
end

%% 获得坐标原点的位置，
% 若坐标轴的范围不包含坐标原点，则选择最靠近原点的一角作为坐标轴的交点，
% 坐标轴的箭头指向正向
x_range = get(h_axi, 'XLim');
y_range = get(h_axi, 'YLim');
op = [0, 0]; % 默认交点为坐标原点
if x_range(1) > 0
    op(1) = x_range(1);
elseif x_range(2) < 0
    op(1) = x_range(2);
else
    op(1) = 0;
end
if y_range(1) > 0
    op(2) = y_range(1);
elseif y_range(2) < 0
    op(2) = y_range(2);
else
    op(2) = 0;
end
op = CoorFromAxis2Fig(h_axi, op); % 转换为在fig上的坐标

% 获得axis的坐标
axis_rec = get(h_axi, 'Position'); % axis在fig的坐标(x,y,w,h)
% 获得fig句柄
h_fig = get(h_axi, 'Parent');
% 绘制 x 坐标轴
if find('x'==xy_visible)
    xarrow_x = [axis_rec(1)-0.05*axis_rec(3), axis_rec(1)+1.05*axis_rec(3)];
    xarrow_y = [op(2), op(2)];
    xarrow = annotation(h_fig, 'arrow', xarrow_x, xarrow_y);
    set(xarrow, 'HeadStyle', 'plain', 'HeadWidth', head_width, 'Color', arrow_color);
end
% 绘制 y 坐标轴
if find('y'==xy_visible)
    yarrow_x = [op(1), op(1)];
    yarrow_y = [axis_rec(2)-0.05*axis_rec(4), axis_rec(2)+1.05*axis_rec(4)];
    yarrow = annotation(h_fig, 'arrow', yarrow_x, yarrow_y);
    set(yarrow, 'HeadStyle', 'plain', 'HeadWidth', head_width, 'Color', arrow_color);
end
% 关闭默认的坐标轴
set(h_axi, 'Visible', 'off');

%% 是否显示坐标标签
if xlabel_str
    XArrowLabel(xarrow, xlabel_str);
end
if ylabel_str
    YArrowLabel(yarrow, ylabel_str);
end
if olabel_str
    OriginLabel(op, olabel_str);
end

end

function YArrowLabel(arrow, str)
% 给 y 坐标轴添加标签
p = [0, 0];
arrow_x = get(arrow, 'X');
arrow_y = get(arrow, 'Y');
p(1) = arrow_x(2);
p(2) = arrow_y(2);

param.Color = [0.8, 0.52, 0.98];
param.FontSize = 14;

FigPointLabel(p, str, 'east', param);
end

function XArrowLabel(arrow, str)
% 给 x 坐标轴添加标签
p = [0, 0];
arrow_x = get(arrow, 'X');
arrow_y = get(arrow, 'Y');
p(1) = arrow_x(2);
p(2) = arrow_y(2);

param.Color = [0.8, 0.52, 0.98];
param.FontSize = 14;

FigPointLabel(p, str, 'north', param);
end

function OriginLabel(p, str)
% 给 x 坐标轴添加标签
param.Color = [0.8, 0.52, 0.98];
param.FontSize = 14;

FigPointLabel(p, str, 'southwest', param);
end
