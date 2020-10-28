%%%%求解圆弧和直线方程的交点坐标%%%%%%
function [path_line_start path_line_goal]=solve_line_circle(r,line_obstacle,p)
[n0 n1]=size(line_obstacle);
syms x  y
j=1;
for i=1:1:n0

[c,d]=solve((x-line_obstacle(i,1))^2+(y-line_obstacle(i,2))^2==r,y-p.start(2)==(x-p.start(1))*(p.goal(2)-p.start(2))/(p.goal(1)-p.start(1)),x,y)
a=c;
b=d;
if a(1)>a(2)
path_line_start(j,1)=a(2,1);
path_line_start(j,2)=b(2,1);
path_line_goal(j,1)=a(1,1);
path_line_goal(j,2)=b(1,1);
else
path_line_start(j,1)=a(1,1);
path_line_start(j,2)=b(1,1);
path_line_goal(j,1)=a(2,1);
path_line_goal(j,2)=b(2,1);
end
j=j+1;

end




end