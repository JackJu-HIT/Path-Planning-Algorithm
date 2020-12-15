%%%本函数是验证起点和终点的连线经过障碍物的点%%%%%
function  [line_obstacle]=test_if_pass_obstacle(start,goal,MAP)
%%建立直线函数方程，并检测障碍物
if start==goal
    disp("起始点和终点横坐标不能重合，请重新设置并再次尝试运行程序");
end
[n0 n1]=size(MAP);
j=1;
for i=1:1:n0
    for k=1:1:n1
   if(MAP(i,k)==1)
   a=i-start(2);
   b=(k-start(1))*(goal(2)-start(2))/(goal(1)-start(1));
   if a==b
       line_obstacle(j,1)=k;
       line_obstacle(j,2)=i;
       j=j+1;
   end
   end
       
    end
end
%%%去除重复的行元素坐标
line_obstacle=unique(line_obstacle,'rows'); 
end