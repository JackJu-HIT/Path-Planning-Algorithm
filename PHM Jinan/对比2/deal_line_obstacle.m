%%%%%%处理直线上的障碍物点%%%%%%%%
function [path2  STEP_TIME]=deal_line_obstacle(obstacle,path_line_start,path_line_goal,p)
[n0 n1]=size(path_line_start);
start=p.start;
goal=p.goal;
path1=[];
STEP_TIME=0;
for i=1:1:n0
  p.start=path_line_start(i,:);
  p.goal=path_line_goal(i,:);
  [path K]=AStar(obstacle,p,0.5)%A*算法
% [Goal_orgin time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,start,goal,Xsum_orgin,n0,obstacle);
  path1=[path1;path];
  STEP_TIME=STEP_TIME+K;
end
path2=[start;path1;goal];
end