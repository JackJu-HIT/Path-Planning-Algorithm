function [nx,A,B,a,b,c,d]=cubic(x,y)
nx=length(x); %计算x长度
h1=diff(x);%计算x之间的差
a=y;  %系数a
A=zeros(nx-1,nx-1);
A(1,1)=1;
for i=2:(nx-3)
%     if i~=nx
        A(i,i)= 2.0 * (h1(i-1) + h1(i));
        A(i,i-1)= h1(i-1);
        A(i,i+1)= h1(i+1);
%     else 
        
end
%   A(nx-1,nx-1)=;
    i=(nx-2);
    A(i,i)= 2.0 * (h1(i-1) + h1(i));
        A(i,i-1)= h1(i-1);
        A(i,i+1)= h1(i+1);
       A(nx-1,nx-1)=1;
%     A(i,i-1)= h(i-1);
%     A(i-1, i)= h(i-1);
%     A(1,2) = 0.0;
%     A(nx,nx - 1)= 0.0;
%     A(nx, nx)= 1.0;
B=zeros(nx-1,1);
for i=2:nx-2
 B(i,1)=6.0 * (a(i+1) - a(i)) / h1(i) - 6.0 * (a(i) -a(i-1)) / h1(i-1);
end
B(1,1)=0;
B(nx-1,1)=0;
m=inv(A).*B; %解方程组求m
c=m/2.0;%系数c
for i=1:nx-1
d(i)=(c(i + 1) - c(i)) / (3.0 * h1(i)); %计算系数d
b(i) = (a(i + 1) - a(i)) / h1(i) - h1(i) * (c(i + 1) + 2.0 * c(i)) / 3.0;%系数b
end
end
% h(i)
% ————————————————
% 版权声明：本文为CSDN博主「Robert--cao」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/caokaifa/article/details/81605914
% %{
% 这段程序主要是求三次样条插值的系数 y=ax^3+bx^2+cx+d
% 作者：Robert.Cao
% ?%}