function [Yatx,Yaty]=compute_Attract(X,Xsum,Xsum_test,k,angle1,angle2,b,Po,n0,w)
%把路径上的临时点作为每个时刻的Xgoal
disp("正在计算目标点引力...");
R=(X(1)-Xsum(1,1))^2+(X(2)-Xsum(1,2))^2;%路径点和目标的距离平方
r=sqrt(R);%路径点和目标的距离
Yatx1=k*r*cos(angle1);%angle=Y(1)
Yaty1=k*r*sin(angle1);
[n3 n4]=size(Xsum_test);
Yatx2=0;
Yaty2=0;
[a b]=size(angle2);
%if w~=0
for i=1:1:n3
R1=(X(1)-Xsum_test(i,1))^2+(X(2)-Xsum_test(i,2))^2;%路径点和A*吸引点的距离平方
r2=sqrt(R1);%路径点和目标的距离
Yatx2=Yatx2+50*r2*cos(angle2(i));%angle=Y(1)%%比重
Yaty2=Yaty2+50*r2*sin(angle2(i));
disp("正在使用A*路径点计算路径...");
end
Yatx=Yatx1+Yatx2;
Yaty=Yaty1+Yaty2;
end