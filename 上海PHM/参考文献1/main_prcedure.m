%Author:Jack Ju
%********根据参考文献基于改进A_算法和人工势场法的搬运机器人路径规划研究_蔺博 主程序**********%
clear all;
%障碍和目标，起始位置都已知的路径规划,意图实现从起点可以规划出一条避开障碍到达目标的路径。
%初始化车的参数
%Xo=[0 0];%起点位置
k=40;%计算引力需要的增益系数15
K=0;%初始化
m=5;%计算斥力的增益系数，都是自己设定的5。
Po=2;%障碍影响距离，当障碍和车的距离大于这个距离时，斥力为0，即不受该障碍的影响。也是自己设定。
%碍物的个数
w=0;
n=50;%障碍个数   需要你修改
a=0.5;
l=0.01;%步长
J=3000;%循环迭代次数
%如果不能实现预期目标，可能也与初始的增益系数，Po设置的不合适有关。
%end
%给出障碍和目标信息
p.start=[1 1];  %起始点
p.goal=[11 11];  %目标点
start=p.start;
goal=p.goal;
p.XYMAX=15; %%代表我们要画一个地图的长和宽
%obstacle=GetBoundary(p);%得到边界数据
nObstacle=n;%在地图中随机加入n个障碍物 
obstacle=GetObstacle(nObstacle,p)%障碍物和边界
obstacle=[10,14;6,8;12,8;8,3;5,7;14,9;13,10;8,6;9,6;9,15;3,1;5,13;7,14;3,12;13,1;3,4;3,5;3,10;3,2;7,11;5,2;14,10;6,7;3,12;14,11;15,14;7,13;2,5;4,10;6,3;9,0;4,11;9,8;11,7;3,14;2,9;4,9;5,13;6,12;8,9;1,3;4,4;12,13;0,0;14,7;11,3;7,15;9,11;4,8;7,7]
[n0 n1]=size(obstacle);
%******************调用A*算法备份*********%
t3=clock;
 path1=AStar(obstacle,p);%A*算法
 t4=clock;
 A_time=etime(t4,t3)
 [x g]=size(path1);
if length(path1)>=1
%     plot(path1(:,1),path1(:,2),'-+r','LineWidth',2);hold on;
end
%%%%检测生成路径的拐点*******
%%%%%%具体实现通过改点前后斜率不同判断
guaidian_x=[];
guaidian_y=[];
for i=2:1:x-1
jude1=(path1(i,2)-path1(i-1,2))/(path1(i,1)-path1(i-1,1));
jude2=(path1(i+1,2)-path1(i,2))/(path1(i+1,1)-path1(i,1));
if jude1~=jude2

  guaidian_x=[guaidian_x;path1(i,1)];
  guaidian_y=[guaidian_y;path1(i,2)];
end
end
% guaidian_x=sort(guaidian_x);
% guaidian_y=sort(guaidian_y);
guaidian=[guaidian_x,guaidian_y];
guaidian=[p.start;guaidian;p.goal]
guaidian=unique(guaidian,'rows')
%legend('A*算法轨迹');
% %**********基于改进A_算法和人工势场法的搬运机器人路径规划研究_蔺博见下人工势场法*******************……%
t1=clock;
[x_num y_num]=size(guaidian);
path_combine=[];
for i=1:1:x_num-1
p.start=guaidian(i,:);
p.goal=guaidian(i+1,:);
Xsum_orgin=[p.goal;obstacle];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%这个向量是(n+1)*2维，其中[10 10]是目标位置，剩下的都是障碍的位置。
[Goal_orgin time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum_orgin,n0,obstacle)
% [Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum,path1,n0,x,obstacle);
path_combine=[path_combine;Goal_orgin]
end
X1=path_combine(:,1);
Y1=path_combine(:,2);
%计算时间
t2=clock;
art_time=etime(t2,t3)
m1=[X1];
N1=[Y1];
plot(m1,N1,'g','LineWidth',2)
% legend('人工势场法');
hold on
% hold on
%plot(obstacle(:,1),obstacle(:,2),'o')%,p.goal(1),p.goal(2),'v',p.start(1),p.start(2),'ms',X,Y,'.r');
% legend('预设定起点','预设定终点','A*算法轨迹','改进后融合算法','障碍物');
% hold on
% title("人工势场法和A*融合算法，加入50个障碍物仿真结果")








%******调用改进后的融合算法（A*和人工势场的融合算法）并绘制
t5=clock;
path_fusion=[];
%%%%改进
% for i=1:1:x_num-1
% p.start=guaidian(i,:);
% p.goal=guaidian(i+1,:);
% Xsum=[p.goal;obstacle;path1];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%这个向量是(n+1)*2维，其中[10 10]是目标位置，剩下的都是障碍的位置。
% [Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum,path1,n0,x,obstacle);
% path_fusion=[path_fusion;Goal]
% end
% %%%开始绘制改进后的图像
% X=path_fusion(:,1);
% Y=path_fusion(:,2);
Xsum=[goal;obstacle;path1];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%这个向量是(n+1)*2维，其中[10 10]是目标位置，剩下的都是障碍的位置。
[Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,start,goal,Xsum,path1,n0,x,obstacle);
%%%开始绘制改进后的图像
X=Goal(:,1);
Y=Goal(:,2);
t6=clock;
fusion_time=etime(t6,t5)+A_time
m=[X];
N=[Y];
plot(m,N,'-b','LineWidth',2)
%legend('改进后融合算法');
%legend('Fusion algorithm');
hold on
plot(obstacle(:,1),obstacle(:,2),'o')%,p.goal(1),p.goal(2),'v',p.start(1),p.start(2),'ms',X,Y,'.r');
%legend('人工势场法','预设定起点','预设定终点','A*算法轨迹','改进后融合算法','障碍物');
plot(start(1),start(2),'*r','LineWidth',2);hold on;
plot(goal(1),goal(2),'*b','LineWidth',2);hold on;

legend('Reference method [6] ','Fusion algorithm proposed in this paper','Obstacles','Starting point','Terminal point');
hold on
%title("人工势场法和A*融合算法，加入50个障碍物仿真结果")
% title("Artificial potential field method and A-star fusion algorithm")
FontSize = 25;
set(gca,'FontSize',FontSize);
xlabel('x axis')
ylabel('y axis')

%%%%%本部分要计算生成的路径长度
%计算人工势场法路径长度
N1=size(X1)
art_length=0;
for i=1:1:(N1-1)
   art_length=art_length+((X1(i,1)-X1(i+1,1))^2+(Y1(i,1)-Y1(i+1,1))^2)^(1/2);
end
disp(['参考文献人工势场法的长度',art_length])
%计算A*法路径长度
N2=size(path1)
A_length=0;
for i=1:1:(N2-1)
   A_length=A_length+((path1(i,1)-path1(i+1,1))^2+(path1(i,2)-path1(i+1,2))^2)^(1/2);
end
disp(['A*算法的长度',A_length])

%融合算法的路径长度
N3=size(X)
Fusion_length=0;
for i=1:1:(N3-1)
   Fusion_length=Fusion_length+((X(i,1)-X(i+1,1))^2+(Y(i,1)-Y(i+1,1))^2)^(1/2);
end
disp(['融合算法的长度',Fusion_length])
