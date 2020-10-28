function [flag,targetInd]=FindList(m,open,close)
%{
函数功能：
如果相邻节点(m存储其信息)  已经在Closelist中，则flag = 1  targetInd = 其所在close的行数，用来定位
如果相邻节点(m存储其信息)    不在Openlist 中，则flag = 2  targetInd = []
如果相邻节点(m存储其信息)  已经在Openlist 中，则flag = 3  targetInd = 其所在open的行数，用来定位

%}

%如果openlist为空，则一定不在openlist中
if  isempty(open)
    flag = 2;
    targetInd = [];
    
else  %open不为空时，需要检查是否在openlist中
    %遍历openlist，检查是否在openlist中
    for io = 1:length(open(:,1))
        if isequal(m(1:2), open(io,1:2))  %在Openlist中进行比对，当前的点周围的点是否在open
            flag = 3;
            targetInd = io;
            return;
        else  %不在Openlist中
            flag = 2;
            targetInd=[];
        end
    end
end

%如果能到这一步，说明：  一定不在Openlist中    那么需要判断是否在closelist中
%遍历Closelist（注意closelist不可能为空）
for ic = 1:length(close(:,1))
    if isequal(m(1:2),close(ic,1:2))  %在Closelist中
        flag = 1;
        targetInd = ic;
        return;%在Closelist中直接return
    end
end
%{
以下代码用于测试此函数的正确性：
open = [ 1,1 ; 2,2; 3,3; 4,4; 5,5; 6,6; 7,7; 8,8; 9,9];
%还有一种情况：open列表为空
close = [1,2 ; 2,3; 3,4; 4,5; 5,6; 6,7; 7,8];

m1 = [5,6]; %在close中 此时flag应为1 targetInd 应为 5
m2 = [0,0]; %不在open中， 此时flag应为2 targetInd 应为空[]
m3 = [3,3]; %在open中 此时flag应为3  targetInd 应为 3

[flag,targetInd] = FindList(m1,open,close)  %flag = 1 targetInd = 5
[flag,targetInd] = FindList(m2,open,close)  %flag = 2 targetInd = []
[flag,targetInd] = FindList(m3,open,close)  %flag = 3 targetInd = 3
%}
end
% ————————————————
% 版权声明：本文为CSDN博主「lee_yunwen」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/u014795863/article/details/88831920