%Example on the use of AStar Algorithm in an occupancy grid. 
%%%%改进A_算法在AGV小车路径规划中的应用_王立春
clear
%%% Generating a MAP
%1 represent an object that the path cannot penetrate, zero is a free path
 MAP=int8(zeros(128,140));%140));
% % MAP( 30,20:120)=1;
 MAP(20,25:30)=1;
 MAP(30,30:40)=1;
 MAP(40,20:30)=1;
 MAP(60,43:60)=1;
 MAP(70,20:40)=1;
 MAP(80,55:80)=1;
 MAP(90,40:50)=1;
 MAP(100,66:80)=1;
 

%地图2
%  MAP(20,20:80)=1;
%  MAP(19:30,20)=1;
%  MAP(48,20:80)=1;
 
%  MAP(48:60,80)=1;
%   MAP(80:100,80)=1;
%  MAP(40,20:120)=1;
% MAP(50,20:100)=1;
%%地图1
%%%orgin
% MAP(1:64,1)=-3;
% MAP(120,3:100)=1;
% MAP(125:128,40:60)=1;
% MAP(120:128,100:120)=1;
% MAP(126,100:118)=0;
% MAP(120:126,118)=0;
% MAP(100:120,100)=1;
% MAP(114:124,112:118)=0;
% MAP(1,1:128)=1;
% MAP(128,1:128)=1;
% MAP(100,1:130)=1;
% MAP(50,28:128)=1;
% MAP(20:30,50)=1;
% MAP(1:128,1)=1;
% MAP(1:65,128)=1;
% MAP(1,1:128)=1;
% MAP(128,1:128)=1;
% MAP(10,1:50)=1;
% MAP(25,1:50)=1;
% MAP(40,40:50)=1;
% MAP(40,40:45)=1;
% MAP(80,20:40)=1;
% MAP(80:100,40)=1;
% MAP(80:100,120)=1;
% MAP(120:122,120:122)=1;
% MAP(120:122,20:25)=1;
% MAP(120:122,10:11)=1;
% MAP(125:128,10:11)=1;
% MAP(100:110,30:40)=1;
% MAP(1:20,100:128)=1;
% MAP(10:20,80:128)=1;
% MAP(20:40,80:90)=1;
% MAP(1:40,90:90)=1;
% MAP(100:105,70:80)=1;

%Start Positions
start=[20 10];
StartX=start(1);
StartY=start(2);
value_B=1;
%Generating goal nodes, which is represented by a matrix. Several goals can be speciefied, in which case the pathfinder will find the closest goal. 
%a cell with the value 1 represent a goal cell
% 生成目标节点，用矩阵表示。 可以指定几个目标，在这种情况下，探路者将找到最接近的目标。
% ％a值为1的单元格代表目标单元格
GoalRegister=int8(zeros(128,140));
goal=[70 110]
%GoalRegister(80,80)=1;%110 80
GoalRegister(goal(2),goal(1))=1;




%Number of Neighboors one wants to investigate from each cell. A larger
%number of nodes means that the path can be alligned in more directions. 
%Connecting_Distance=1-> Path can  be alligned along 8 different direction.
%Connecting_Distance=2-> Path can be alligned along 16 different direction.
%Connecting_Distance=3-> Path can be alligned along 32 different direction.
%Connecting_Distance=4-> Path can be alligned along 56 different direction.
%ETC......

Connecting_Distance=2; %Avoid to high values Connecting_Distances for reasonable runtimes. 



%%%%%传统A*算法*********
t1=clock;
OptimalPath=ASTARPATH(StartX,StartY,MAP,GoalRegister,1);
t2=clock;
TA_time=etime(t2,t1);%%计算传统A星时间
% figure(10)
% plot(OptimalPath(:,2),OptimalPath(:,1),'b-+');
% hold on
%%%%%%%%提出的改进A*算法
%%%%*****验证该直线穿过的障碍物的点%%
t3=clock;
[line_obstacle]=test_if_pass_obstacle(start,goal,MAP);
%计算线段上障碍物的起点终点处理
 r=4;
 [path_line_start_ago path_line_goal_ago]=solve_line_circle(r,line_obstacle,start,goal);
 t9=clock;

 
 [path2  STEP_TIME]=deal_line_obstacle(MAP,path_line_start_ago,path_line_goal_ago,start,goal,GoalRegister,value_B,Connecting_Distance)
 t4=clock;
 IMA_time=etime(t4,t3);%%改进A星时间
 %path2=unique(path2,'rows'); 

% Running PathFinder
%OptimalPath=ASTARPATH(StartX,StartY,MAP,GoalRegister,Connecting_Distance)
% path2=flip(path2)
% % End. 

if size(path,2)>1
figure(10)
imagesc((MAP))
    colormap(flipud(gray));

hold on
% plot(OptimalPath(1,2),OptimalPath(1,1),'o','color','k')
% plot(OptimalPath(end,2),OptimalPath(end,1),'o','color','b')
% plot(OptimalPath(:,2),OptimalPath(:,1),'r')
plot(OptimalPath(:,2),OptimalPath(:,1),'b-+');%%%传统A星算法
plot(path2(:,2),path2(:,1),'r+-');%%%改进A*算法
plot(path2(1,2),path2(1,1),'*r','LineWidth',2);%'color','k')  %%起点
plot(path2(end,2),path2(end,1),'*b','LineWidth',2)%'o','color','b')
legend('Reference method Path','Improved A-star Path','Start','Goal')
%%%设置字体大小
Fontsize=15;
set(gca,'FontSize',Fontsize);
xlabel('x axis');
ylabel('y axis');

% title("Proposed improved A-star Algorithm!")
else 
     pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
 end









showNeighboors=0; %Set to 1 if you want to visualize how the possible directions of path. The code
%below are purley for illustrating purposes. 
if showNeighboors==1
%



%2
NeigboorCheck=[0 1 0 1 0;1 1 1 1 1;0 1 0 1 0;1 1 1 1 1;0 1 0 1 0]; %Heading has 16 possible allignments
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(2+1);
figure(2)

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 
grid on
title('Connecting distance=2')
end

%3
NeigboorCheck=[0 1 1 0 1 1 0;1 0 1 0 1 0 1;1 1 1 1 1 1 1;0 0 1 0 1 0 0;1 1 1 1 1 1 1;1 0 1 0 1 0 1;0 1 1 0 1 1 0]; %Heading has 32 possible allignments
figure(3)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(3+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
 grid on
title('Connecting distance=3')

end
 
%4
NeigboorCheck=[0 1 1 1 0 1 1 1 0;1 0 1 1 0 1 1 0 1;1 1 0 1 0 1 0 1 1;1 1 1 1 1 1 1 1 1;0 0 0 1 0 1 0 0 0;1 1 1 1 1 1 1 1 1;1 1 0 1 0 1 0 1 1 ;1 0 1 1 0 1 1 0 1 ;0 1 1 1 0 1 1 1 0];  %Heading has 56 possible allignments
figure(4)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(4+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=4')

end
%1
NeigboorCheck=[1 1 1;1 0 1;1 1 1];
figure(1)
[row col]=find(NeigboorCheck==1);
Neighboors=[row col]-(1+1);

for p=1:size(Neighboors,1)
  i=Neighboors(p,1);
       j=Neighboors(p,2);
      
     plot([0 i],[0 j],'k')
 hold on
 axis equal
grid on
title('Connecting distance=1')

end
end
X=OptimalPath(:,1);
Y=OptimalPath(:,2);
N3=size(X);
A_length=0;
for i=1:1:(N3-1)
   A_length=A_length+((X(i,1)-X(i+1,1))^2+(Y(i,1)-Y(i+1,1))^2)^(1/2);
end
%disp(['A*算法改后的长度',A_length])
TA_length=vpa(A_length)
% end
X=path2(:,1);
Y=path2(:,2);
N3=size(X);
improved_length=0;
for i=1:1:(N3-1)
   improved_length=improved_length+((X(i,1)-X(i+1,1))^2+(Y(i,1)-Y(i+1,1))^2)^(1/2);
end
%disp(['A*算法改后的长度',A_length])
improved_length=vpa(improved_length)

