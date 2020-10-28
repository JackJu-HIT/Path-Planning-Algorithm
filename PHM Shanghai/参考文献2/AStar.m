function path=AStar(obstacle,p)
path=[];%用于存储路径
%OpenList
open=[p.start(1) p.start(2) h(p.start,p.goal) 0 p.start(1) p.start(2)];%有问题！！！！！！！
%CloseList
close=[];
next=MotionModel();%更新状态--下一步的八个点
findFlag=false;%目标标志
while ~findFlag
    if isempty(open(:,1)) 
        disp('No path to goal!!');
        return;
    end
    %判断是否达到目标
%     if isSamePosi(open(1,1:2),p.goal)%%%对第一行的最短估价函数坐标与终点坐标比对
%         disp('Find Goal!!');
%         close=[open(1,:);close]%%累计之前找到的结
%         open(1,:)=[];%%从open list清空第一行的点即找到的目标点
%         findFlag=true;%%%标志位会终止while大循环。
%         break;
%     end 
%判断目标点是否出现在open列表中
    [isopenFlag,Id]=isopen(p.goal,open);
    if isopenFlag
        disp('Find Goal!!');
        close =[open(Id,:);close]
        findFlag=true;
        break;
    end
     [Y,I] = sort(open(:,3))%对OpenList中第三列排序
    open=open(I,:);    %%矩阵以第三列重新排
    %------------------b.将F值最小的节点(即open中第一行节点)，放到close第一行(close是不断积压的)，作为当前节点
    close = [open(1,:);close];
    current= open(1,:);%%%选择最小F值当前节点，考察当前节点
    open(1,:)=[];%因为已经从open中移除了，所以第一列需要为空
    %找到最优轨迹放到close list保存
    
    for in=1:length(next(:,1))
%         m=[open(1,1)+next(in,1) open(1,2)+next(in,2) open(1,3) 0 0 0];%%搜当前点的寻周围的点！！！！！！
%         m(3)=next(in,3)+h(m(1:2),p.goal);%m--F值=f+g，其中next（in,3）是起点点到当前点的距离，h(m(1:2),p.goal)为当欠点的距离。
        
        m=[current(1,1)+next(in,1) , current(1,2)+next(in,2) ,0,0,0,0]; 
        m(4)=current(1,4)+next(in,3); % m(4) 相邻节点G值
        m(3)=m(4)+h(m(1:2),p.goal);%m(3)=next(in,3)+h(m(1:2),p.goal);% m(3)  相邻节点F值
        
        if isObstacle(m,obstacle)%%如果是真的，则直接跳出,重新扫描下一个周围的点，障碍物走不了，那就换一个呗
            continue;
        end
        %判断周围的点在不在openlist中。如果不在则加入到open list中
        %{
函数功能：
如果相邻节点(m存储其信息)  已经在Closelist中，则flag = 1  targetInd = 其所在close的行数，用来定位
如果相邻节点(m存储其信息)    不在Openlist 中，则flag = 2  targetInd = []
如果相邻节点(m存储其信息)  已经在Openlist 中，则flag = 3  targetInd = 其所在open的行数，用来定位

%}
        [flag, targetInd]=FindList(m,open,close)
%         if flag==3%1 %在Openlist中
%             disp('已存在OpenList中')
%             continue;
%         elseif flag==1%2 
%             disp('已存在CloseList中')
%             continue;
%         else
%             open=[open;[m open(1,1) open(1,2)]]%%%不在openlist中 %有问题%%每次open 第一行第一列和第一行第一列都在更新
%         end
%     end
%     if findFlag==false
%         %将OpenList中的第一行移动到CloseList中
%         close=[close; open(1,:)]
%         open(1,:)=[];
%     end

 %>>如果它在Closelist中，忽略此相邻节点
        if flag==1 
            continue;
        %>>如果它不在Openlist中，加入Openlist,并把当前节点设置为它的父节点
        elseif flag==2 
            m(5:6)=[current(1,1),current(1,2)];%将当前节点作为其父节点
            open=[open;m];%将此相邻节点加放openlist中
        %>>剩下的情况就是它在Openlist中，检查由当前节点到相邻节点是否更好，如果更好则将当前节点设置为其父节点，并更新F,G值；否则不操作    
        else
            %由当前节点到达相邻节点更好(targetInd是此相邻节点在open中的行号此行的第3列是代价函数F值)
            if m(4)<open(targetInd,4) %m(3) < open(targetInd,3)open(targetInd,4)之前已经存在了
                %更好，则将此相邻节点的父节点设置为当前节点，否则不作处理
                m(5:6)=[current(1,1),current(1,2)];%将当前节点作为其父节点
                open(targetInd,:)=m;%将此相邻节点在Openlist中的数据更新%%%最后还要赋值给close
            end
        end
    end
end
path=GetPath(close,p.start);%回溯路径
end

% ————————————————
% 版权声明：本文为CSDN博主「晓憶」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/sinat_16910875/article/details/85311819
% 实现不揍为：	
% 1、将起始点存放进OpenList中
% 2、对OpenList中的第三列（代价函数值）进行排序
% 3、计算当前点周围八个点的F值，并存入OpenList中
% 4、将OpenList中的第一行移动到CloseList中
%https://blog.csdn.net/sinat_16910875/article/details/85311819
%https://blog.csdn.net/u014795863/article/details/88831920
%%%%%重要参考代码解释https://blog.csdn.net/u014795863/article/details/88831920
% %%%……A*算法具体步骤如下：
%
% 1、首先将起始点添加进“开启列表”。
% 2、重复如下步骤：
%    　a) 寻找开启列表中F值最低的节点。我们称其为“当前节点”。
%    　b) 把它从“开启列表”中移除，并添加进“关闭列表”。
%    　c) 检查“当前节点”是否是“目标节点”
%       　* 如果是，停止搜索，跳到第 3 步；
%       　* 如果不是，继续下面步骤…… 　
%    　d) 寻找“当前节点”邻近的节点
%       　* 如果它不可通过或者已经在关闭列表中，略过它。反之如下。
%       　* 如果它不在开启列表中，把它添加进开启列表。把当前节点作为这一节点的父节点。记录这一格的F,G,和H值。
%       　* 如果它已经在开启列表中，检查新路径对它G值的产生的影响
%           　a. 如果它的G值因为新路径变大，那么保持原来的状态，不作任何改变；
%           　b. 如果G值变小，说明新路径更好，将其父结点改为“当前结点”，更新G和F值。
%    　e) 检查列表是否为空，如果为空，说明路径未找到，直接返回，不继续任何步骤。
% 3、保存路径。从目标节点开始，沿着每一节点的父节点移动直到回到起始节点。这就是我们要











% A*()
% {
% Open = [起始节点];
% Closed = [];
% while (Open表非空)
% {
% 从Open中取得一个节点X，并从OPEN表中删除。
% 　  if (X是目标节点)
% 　　{
% 　　  求得路径PATH；
% 　　  返回路径PATH；
% 　　}
% 　　for (每一个X的子节点Y)
% 　　{
% if (Y不在OPEN表和CLOSE表中)
% 　　  {
%          求Y的估价值；
% 并将Y插入OPEN表中；
% }
% 　　  //还没有排序
% 　    else if (Y在OPEN表中)
% 　　  {
% if (Y的估价值小于OPEN表的估价值)
% 更新OPEN表中的估价值；
% }
% 　　   else //Y在CLOSE表中
% 　     {
%          if (Y的估价值小于CLOSE表的估价值)
% 　　     {
% 更新CLOSE表中的估价值；
% 从CLOSE表中移出节点，并放入OPEN表中；
% }
% }
% 将X节点插入CLOSE表中；
% 按照估价值将OPEN表中的节点排序；
% }//end for
% 　}   //end while
% }     //end functi
% ————————————————
% 版权声明：本文为CSDN博主「罗家山的蚊子」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/autonavi2012/article/details/80923431