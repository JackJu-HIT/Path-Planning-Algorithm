%%%本函数是验证起点和终点的连线经过障碍物的点%%%%%
function  [line_obstacle]=test_if_pass_obstacle(p,obstacle)
%%建立直线函数方程，并检测障碍物
if p.start(1)==p.goal(1)
    disp("起始点和终点横坐标不能重合，请重新设置并再次尝试运行程序");
end
[n0 n1]=size(obstacle);
j=1;
for i=1:1:n0
   a=obstacle(i,2)-p.start(2);
   b=(obstacle(i,1)-p.start(1))*(p.goal(2)-p.start(2))/(p.goal(1)-p.start(1));
   if a==b
       line_obstacle(j,1)=obstacle(i,1);
       line_obstacle(j,2)=obstacle(i,2);
       j=j+1;
   end
       
end
%%%去除重复的行元素坐标
line_obstacle=unique(line_obstacle,'rows'); 
end