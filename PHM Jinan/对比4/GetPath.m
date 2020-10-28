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
% ————————————————
% 版权声明：本文为CSDN博主「lee_yunwen」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/u014795863/article/details/88831920
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
% ————————————————
% 版权声明：本文为CSDN博主「晓憶」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/sinat_16910875/article/details/85311819获取路径