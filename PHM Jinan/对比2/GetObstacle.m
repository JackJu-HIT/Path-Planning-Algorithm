function obstacle=GetObstacle(n0bstacle,p)
nob=n0bstacle;
obstacle=[];%修改后
ob=round(rand([nob,2])*p.XYMAX);%%%rand([nob,2])表示nob行2列的小于1的矩阵
removeInd=[];
for io=1:length(ob(:,1))
   if(isSamePosi(ob(io,:),p.start))||(isSamePosi(ob(io,:),p.goal))%%%如果该障碍物与起始点或者终点重合，则删除。
        removeInd=[removeInd;io];
   end  
end
ob(removeInd,:)=[];   %%%将于目标点和起点重合的点删掉，因为他们不是障碍物
obstacle=[obstacle;ob];%%%去除点重点的障碍物坐标。
end

% ————————————————
% 版权声明：本文为CSDN博主「晓憶」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/sinat_16910875/article/details/85311819
% 获得地图中的障碍物