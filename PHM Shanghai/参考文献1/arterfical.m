function  [Goal_orgin  time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,start,goal,Xsum,n0,obstacle)
p.start=start;
p.goal=goal;
x=0;
Xj=p.start;%Xo;%j=1循环初始，将车的起始坐标赋给Xj
for j=1:J%循环开始
    Goal_orgin(j,1)=Xj(1);%Goal是保存车走过的每个点的坐标。刚开始先将起点放进该向量。
    Goal_orgin(j,2)=Xj(2);
%调用计算角度模块
  [ Theta] =compute_angle(Xj,Xsum,n0,x);%Theta是计算出来的车和障碍，和目标之间的与X轴之间的夹角，统一规定角度为逆时针方向，用这个模块可以计算出来。
%调用计算引力模块
   Angle1=Theta(1);%Theta（1）是车和目标之间的角度，目标对车是引力。
%    if w ~=0
%    Angle2=Theta(n0+1);%Theta（1）是车和A*路径点之间的角度，目标对车是引力。
%     [Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle1,Angle2,0,Po,n0,w);%计算出目标对车的引力在x,y方向的两个分量
%    else 
     [Fatx,Faty]=compute_Attract1(Xj,Xsum,k,Angle1,0,Po,n0);   
%    end
   angle_at=Theta(1);%为了后续计算斥力在引力方向的分量赋值给angle_at
  % [Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle1,Angle2,0,Po,n,w);%计算出目标对车的引力在x,y方向的两个分量值。
   
    for i=1:n0
       angle_re(i)=Theta(i+1);%计算斥力用的角度，是个向量，因为有n个障碍，就有n个角度。
     end
%调用计算斥力模块
    [Frerxx,Freryy,Fataxx,Fatayy]=compute_repulsion(Xj,Xsum,m,angle_at,angle_re,n0,Po,a);%计算出斥力在x,y方向的分量数组。
%计算合力和方向，这有问题，应该是数，每个j循环的时候合力的大小应该是一个唯一的数，不是数组。应该把斥力的所有分量相加，引力所有分量相加。
    Fsumyj=Faty+Freryy+Fatayy;%y方向的合力
    Fsumxj=Fatx+Frerxx+Fataxx;%x方向的合力
    Position_angle(j)=atan(Fsumyj/Fsumxj);%合力与x轴方向的夹角向量
%计算车的下一步位置
    Xnext(1)=Xj(1)+l*cos(Position_angle(j));
    Xnext(2)=Xj(2)+l*sin(Position_angle(j));
    %保存车的每一个位置在向量中
    Xj=Xnext;
    
    %判断
    e=sqrt((Xj(1)-Xsum(1,1))^2+abs(Xj(2)-Xsum(1,2))^2);
    if (e<0.1)||(Xj(1)-Xsum(1,1)>0)||((Xj(2)-Xsum(1,2))>0)%(abs||(abs(Xj(2)-Xsum(1,2))<0.1)%是应该完全相等的时候算作到达，还是只是接近就可以？现在按完全相等的时候编程。
       K=j;%记录迭代到多少次，到达目标。
       break;
       %记录此时的j值
    end%如果不符合if的条件，重新返回循环，继续执行。
end%大循环结束
time_orgin = K;
K=j+1;
Goal_orgin(K,1)=Xsum(1,1);%把路径向量的最后一个点赋值为目标
Goal_orgin(K,2)=Xsum(1,2);
end