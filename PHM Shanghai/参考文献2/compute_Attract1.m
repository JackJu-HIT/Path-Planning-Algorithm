function [Yatx,Yaty]=compute_Attract1(X,Xsum,k,angle1,b,Po,n)%�������Ϊ��ǰ���꣬Ŀ�����꣬���泣��,���������ĽǶ�
%��·���ϵ���ʱ����Ϊÿ��ʱ�̵�Xgoal
R=(X(1)-Xsum(1,1))^2+(X(2)-Xsum(1,2))^2;%·�����Ŀ��ľ���ƽ��
disp("δʹ��A*·���㣬����·��...")
r=sqrt(R);%·�����Ŀ��ľ���
Yatx=k*r*cos(angle1);%angle=Y(1)
Yaty=k*r*sin(angle1);
end