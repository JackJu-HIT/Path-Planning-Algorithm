function [isopenFlag,Id] = isopen( node,open )

%�жϽڵ��Ƿ���open�б��У���open�У�isopenFlag = 1,����open�У�isopenFlag = 0 .������������

isopenFlag = 0;
Id = 0;

%���open�б�Ϊ�գ�����open�б���
if  isempty(open)
    isopenFlag = 0;

else %open�б�Ϊ��ʱ
    for i = 1:length( open(:,1) )
       if isSamePosi(  node(1:2) , open(i,1:2)  )  %��Openlist��
            isopenFlag = 1;
            Id = i;
            return;
       end 
    end
end

end
% ��������������������������������
% ��Ȩ����������ΪCSDN������lee_yunwen����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/u014795863/article/details/88831920