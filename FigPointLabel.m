function FigPointLabel(p, str, loc, varargin)
%FigPointLabel - 向figure上的点添加文本说明
% 
% Syntex: FigPointLabel(p, str, loc[, param]) 
%
% Input: p 点在figure上的坐标
%        str 待标注的文本
%        loc 文本相对点的位置, 可选值包括：
%            east, west, south, north, northwest, northeast, southwest, southeast
%        param 可选参数，要求输入参数为一个结构体，成员如下：
%               Color 字体的颜色
%               FontSize 字体大小
%              若结构体未包含某项成员，则使用默认值    
% 
% Output: None

%% 输入参数处理
n = length(varargin);
if n == 0
    color = [0.8, 0.52, 0.98]; % label 的默认颜色
    fontsize = 14; % 字体的默认大小
elseif n == 1
    if isfield(varargin{1}, 'Color')
        color = varargin{1}.Color;
    else
        waring("FigPointLabel: Color设置为默认值\n");
        color = [0.8, 0.52, 0.98];
    end
    if isfield(varargin{1}, 'FontSize')
        fontsize = varargin{1}.FontSize;
    else
        fontsize = 14;
        waring("FigPointLabel: FontSize设置为默认值\n");
    end
else
    error('FigPointLabel: 输入参数太多');
end

%% 在坐标轴上的指定某点添加标注
ptx = p(1); pty = p(2);
switch loc
    case 'north'
        label_pos = [ptx-0.05, pty-0.01, 0.1, 0.1];
        hAlign = 'center';
        vAlign = 'bottom';
    case 'south'
        label_pos = [ptx-0.05, pty-0.1, 0.1, 0.1];
        hAlign = 'center';
        vAlign = 'top';
    case 'east'
        label_pos = [ptx, pty-0.05-0.008, 0.1, 0.1];
        hAlign = 'left';
        vAlign = 'middle';
    case 'west'
        label_pos = [ptx-0.1, pty-0.05-0.008, 0.1, 0.1];
        hAlign = 'right';
        vAlign = 'middle';
    case 'northwest'
        label_pos = [ptx-0.1, pty-0.01, 0.1, 0.1];
        hAlign = 'right';
        vAlign = 'bottom';
    case 'northeast'
        label_pos = [ptx, pty-0.01, 0.1, 0.1];
        hAlign = 'left';
        vAlign = 'bottom';
    case 'southwest'
        label_pos = [ptx-0.1, pty-0.1, 0.1, 0.1];
        hAlign = 'right';
        vAlign = 'top';
    case 'southeast'
        label_pos = [ptx, pty-0.1, 0.1, 0.1];
        hAlign = 'left';
        vAlign = 'top';
    otherwise
        label_pos = [ptx-0.05, pty-0.01, 0.1, 0.1];
        hAlign = 'center';
        vAlign = 'bottom';
end
annotation(gcf, 'textbox', ...
        label_pos, ...
        'Color', color, ...
        'String', str, ...
        'Interpreter', 'latex', ...
        'FontSize', fontsize, ...
        'EdgeColor', 'None', ...
        'FitBoxToText', 'On', ...
        'VerticalAlignment', vAlign, ...
        'HorizontalAlignment', hAlign);
end