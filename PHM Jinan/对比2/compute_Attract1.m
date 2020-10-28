function [Yatx,Yaty]=compute_Attract1(X,Xsum,k,angle1,b,Po,n)%输入参数为当前坐标，目标坐标，增益常数,分量和力的角度
%把路径上的临时点作为每个时刻的Xgoal
R=(X(1)-Xsum(1,1))^2+(X(2)-Xsum(1,2))^2;%路径点和目标的距离平方
disp("未使用A*路径点，计算路径...")
r=sqrt(R);%路径点和目标的距离
Yatx=k*r*cos(angle1);%angle=Y(1)
Yaty=k*r*sin(angle1);
end