function line_obj = DrawLine(h_axi, pnt1, pnt2, varargin)
%DrawLine 在图窗上绘制直线，可设置端口类型和直线类型
%
% Syntax: line_obj = DrawLine(h_axi, pnt1, pnt2[, param])
%
% Input: h_axi 坐标轴句柄
%        pnt1 端点1在坐标轴上的坐标
%        pnt2 端点2在坐标轴上的坐标
%        param 可选参数，要求输入参数为一个结构体，成员如下：
%               Type 参考值 'line', 'arrow', 'doublearrow'
%               Color 颜色
%               LineStyle 线型
%               LineWitdh 线宽
%               HeadStyle 箭头的类型
%
% Output: line_obj 图形对象
%
% Note: 自动根据直线长度调整箭头大小

%% 输入参数处理
n = length(varargin);
if n == 0
    type = 'line';
%     type = 'arrow';
%     type = 'doublearrow';
    
    color = [0.8, 0.52, 0.98];
    line_style = '-';
    line_width = 0.5;
    head_style = 'vback2';
    
elseif n == 1
    % 绘制类型
    if isfield(varargin{1}, 'Type')
        type = varargin{1}.Type;
    else
        type = 'line';
    end

    % 颜色
    if isfield(varargin{1}, 'Color')
        color = varargin{1}.Color;
    else
        color = [0.8, 0.52, 0.98];
    end
       
    % 线型
    if isfield(varargin{1}, 'LineStyle')
        line_style = varargin{1}.LineStyle;
    else
        line_style = '-';
    end
    
    % 线宽
    if isfield(varargin{1}, 'LineWitdh')
        line_width = varargin{1}.LineWitdh;
    else
        line_width = 0.5;
    end
    
    % 箭头类型
    if isfield(varargin{1}, 'HeadStyle')
        head_style = varargin{1}.HeadStyle;
    else
        head_style = 'vback2';
    end
    
else
    
    error('Function DrawLine: 输入参数过多！')
    
end

%%
fpnt1 = CoorFromAxis2Fig(h_axi, pnt1); 
fpnt2 = CoorFromAxis2Fig(h_axi, pnt2); 
line_obj = annotation(type, [fpnt1(1), fpnt2(1)], [fpnt1(2), fpnt2(2)]);
line_obj.LineStyle = line_style;
line_obj.LineWidth = line_width;
line_obj.Color = color;

line_length = sqrt(sum((fpnt1-fpnt2).^2));
if line_length < 0.1
    head_size = line_length*0.4*(h_axi.Parent.Position(3))*72/96;
elseif line_length < 0.15
    head_size = line_length*0.2*(h_axi.Parent.Position(3))*72/96;
else
    head_size = 10;
end

head_size = min(10, head_size);

if strcmp(type, 'arrow')
    line_obj.HeadWidth = head_size;
    line_obj.HeadLength = head_size;
    line_obj.HeadStyle = head_style;
end

if strcmp(type, 'doublearrow')
    line_obj.Head1Width = head_size;
    line_obj.Head2Width = head_size;
    line_obj.Head1Length = head_size;
    line_obj.Head2Length = head_size;
    line_obj.Head1Style = head_style;
    line_obj.Head2Style = head_style;
end

end
