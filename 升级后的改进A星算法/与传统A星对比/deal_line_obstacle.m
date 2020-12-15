%%%%%%处理直线上的障碍物点%%%%%%%%
function [path2  STEP_TIME]=deal_line_obstacle(MAP,path_line_start,path_line_goal,Start,Goal,GoalRegister,value_B,Connecting_Distance)
[n0 n1]=size(path_line_start);
start=Start;
goal=Goal;
path1=[];
STEP_TIME=0;
%Connecting_Distance=1;
for i=1:1:n0
  Start=path_line_start(i,:);
  StartX=Start(1);
  StartY=Start(2);
  Goal=path_line_goal(i,:);
  GoalRegister(Goal(2),Goal(1))=1;
%  [path K]=AStar(obstacle,p,0.5,value_B)%A*算法
  path=ASTARPATH_improved(StartX,StartY,MAP,GoalRegister,Connecting_Distance)
  GoalRegister(Goal(2),Goal(1))=0;
  path=flip(path);
% [Goal_orgin time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,start,goal,Xsum_orgin,n0,obstacle);
  path1=[path1;path];
  %STEP_TIME=STEP_TIME+K;
end
path2=[[start(2) start(1)];path1;[goal(2) goal(1)]];
end