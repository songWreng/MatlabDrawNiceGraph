function [img_name] = SaveFig2Img(h_f, varargin)
%SaveFig2Img - 将fig保存为图片
%   
% Syntax: img_name = SaveFig2Img(h_f[, img_name])
% 
% Input: h_f 待保存figure的句柄
%        img_name 保存图像路径
%
% Output: img_name 保存图像路径

%% 输入参数处理
n = length(varargin);
if n == 0
    [file,path] = uiputfile('.\*.png');
    img_name = fullfile(path,file);
elseif n == 1
    img_name = varargin{1};
else
    error('SaveFig2Img: 输入参数太多');
end
%% 保存为图片
frame = getframe(h_f);
img = frame2im(frame);
imwrite(img, img_name);
end

