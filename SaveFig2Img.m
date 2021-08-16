function [img_name] = SaveFig2Img(h_f, varargin)
%SaveFig2Img - ��fig����ΪͼƬ
%   
% Syntax: img_name = SaveFig2Img(h_f[, img_name])
% 
% Input: h_f ������figure�ľ��
%        img_name ����ͼ��·��
%
% Output: img_name ����ͼ��·��

%% �����������
n = length(varargin);
if n == 0
    [file,path] = uiputfile('.\*.png');
    img_name = fullfile(path,file);
elseif n == 1
    img_name = varargin{1};
else
    error('SaveFig2Img: �������̫��');
end
%% ����ΪͼƬ
frame = getframe(h_f);
img = frame2im(frame);
imwrite(img, img_name);
end

