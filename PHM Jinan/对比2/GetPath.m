function [path]=GetPath(close,start)
ind=1;
path=[];
while 1
    path=[path; close(ind,1:2)];
    if isSamePosi(close(ind,1:2),start)
        break;
    end
    for io=1:length(close(:,1))
        if isSamePosi(close(io,1:2),close(ind,5:6))
            ind=io;
            break;
        end
    end
end
end
% ��������������������������������
% ��Ȩ����������ΪCSDN������lee_yunwen����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/u014795863/article/details/88831920
% 
% 
% function path=GetPath(close,start)
% 
% ind=1;
% path=[];
% while 1
%     path=[path; close(ind,1:2)];
%     if isSamePosi(close(ind,1:2),start)   
%         break;
%     end
%     for io=1:length(close(:,1))
%         if isSamePosi(close(io,1:2),close(ind,5:6))
%             ind=io;
%             break;
%         end
%     end
% end
% end
% ��������������������������������
% ��Ȩ����������ΪCSDN��������������ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/sinat_16910875/article/details/85311819��ȡ·��