function [nx,A,B,a,b,c,d]=cubic(x,y)
nx=length(x); %����x����
h1=diff(x);%����x֮��Ĳ�
a=y;  %ϵ��a
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
m=inv(A).*B; %�ⷽ������m
c=m/2.0;%ϵ��c
for i=1:nx-1
d(i)=(c(i + 1) - c(i)) / (3.0 * h1(i)); %����ϵ��d
b(i) = (a(i + 1) - a(i)) / h1(i) - h1(i) * (c(i + 1) + 2.0 * c(i)) / 3.0;%ϵ��b
end
end
% h(i)
% ��������������������������������
% ��Ȩ����������ΪCSDN������Robert--cao����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/caokaifa/article/details/81605914
% %{
% ��γ�����Ҫ��������������ֵ��ϵ�� y=ax^3+bx^2+cx+d
% ���ߣ�Robert.Cao
% ?%}