function [value]=detect_obstacle(a,b,obstacle)
%%%¼ì²âÏß¶ÎÊÇ·ñÍ¨¹ýÕÏ°­Îï
%²âÊÔ
% obstacle=[1.5,3]
% path3=[1,2;2,4;3,6;4,8;5,10];

% a=[3 6];
% b=[5,10];
[n0 n1]=size(obstacle);
p.start(1)=a(1,1);
p.start(2)=a(1,2);
p.goal(1)=b(1,1);
p.goal(2)=b(1,2);
value=0;
for i=1:1:n0
   a=obstacle(i,2)-p.start(2);
   b=(obstacle(i,1)-p.start(1))*(p.goal(2)-p.start(2))/(p.goal(1)-p.start(1));
   if (a==b)&&((obstacle(i,1))>p.start(1))&&(obstacle(i,1)<p.goal(1))
       value=1;
       break;
   end  
end
end