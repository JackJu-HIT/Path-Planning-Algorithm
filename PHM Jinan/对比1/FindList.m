function [flag,targetInd]=FindList(m,open,close)
%{
�������ܣ�
������ڽڵ�(m�洢����Ϣ)  �Ѿ���Closelist�У���flag = 1  targetInd = ������close��������������λ
������ڽڵ�(m�洢����Ϣ)    ����Openlist �У���flag = 2  targetInd = []
������ڽڵ�(m�洢����Ϣ)  �Ѿ���Openlist �У���flag = 3  targetInd = ������open��������������λ

%}

%���openlistΪ�գ���һ������openlist��
if  isempty(open)
    flag = 2;
    targetInd = [];
    
else  %open��Ϊ��ʱ����Ҫ����Ƿ���openlist��
    %����openlist������Ƿ���openlist��
    for io = 1:length(open(:,1))
        if isequal(m(1:2), open(io,1:2))  %��Openlist�н��бȶԣ���ǰ�ĵ���Χ�ĵ��Ƿ���open
            flag = 3;
            targetInd = io;
            return;
        else  %����Openlist��
            flag = 2;
            targetInd=[];
        end
    end
end

%����ܵ���һ����˵����  һ������Openlist��    ��ô��Ҫ�ж��Ƿ���closelist��
%����Closelist��ע��closelist������Ϊ�գ�
for ic = 1:length(close(:,1))
    if isequal(m(1:2),close(ic,1:2))  %��Closelist��
        flag = 1;
        targetInd = ic;
        return;%��Closelist��ֱ��return
    end
end
%{
���´������ڲ��Դ˺�������ȷ�ԣ�
open = [ 1,1 ; 2,2; 3,3; 4,4; 5,5; 6,6; 7,7; 8,8; 9,9];
%����һ�������open�б�Ϊ��
close = [1,2 ; 2,3; 3,4; 4,5; 5,6; 6,7; 7,8];

m1 = [5,6]; %��close�� ��ʱflagӦΪ1 targetInd ӦΪ 5
m2 = [0,0]; %����open�У� ��ʱflagӦΪ2 targetInd ӦΪ��[]
m3 = [3,3]; %��open�� ��ʱflagӦΪ3  targetInd ӦΪ 3

[flag,targetInd] = FindList(m1,open,close)  %flag = 1 targetInd = 5
[flag,targetInd] = FindList(m2,open,close)  %flag = 2 targetInd = []
[flag,targetInd] = FindList(m3,open,close)  %flag = 3 targetInd = 3
%}
end
% ��������������������������������
% ��Ȩ����������ΪCSDN������lee_yunwen����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/u014795863/article/details/88831920