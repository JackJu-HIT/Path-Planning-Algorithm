%********���ݲο����׻��ڸĽ�A_�㷨���˹��Ƴ����İ��˻�����·���滮�о�_���� ������**********%
clear all;
%�ϰ���Ŀ�꣬��ʼλ�ö���֪��·���滮,��ͼʵ�ִ������Թ滮��һ���ܿ��ϰ�����Ŀ���·����
%��ʼ�����Ĳ���
%Xo=[0 0];%���λ��
k=40;%����������Ҫ������ϵ��15
K=0;%��ʼ��
m=5;%�������������ϵ���������Լ��趨��5��
Po=2;%�ϰ�Ӱ����룬���ϰ��ͳ��ľ�������������ʱ������Ϊ0�������ܸ��ϰ���Ӱ�졣Ҳ���Լ��趨��
%����ĸ���
w=0;
n=50;%�ϰ�����   ��Ҫ���޸�
a=0.5;
l=0.01;%����
J=3000;%ѭ����������
%�������ʵ��Ԥ��Ŀ�꣬����Ҳ���ʼ������ϵ����Po���õĲ������йء�
%end
%�����ϰ���Ŀ����Ϣ
p.start=[1 1];  %��ʼ��
p.goal=[11 11];  %Ŀ���
start=p.start;
goal=p.goal;
p.XYMAX=15; %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
%obstacle=GetBoundary(p);%�õ��߽�����
nObstacle=n;%�ڵ�ͼ���������n���ϰ��� 
obstacle=GetObstacle(nObstacle,p)%�ϰ���ͱ߽�
obstacle=[10,14;6,8;12,8;8,3;5,7;14,9;13,10;8,6;9,6;9,15;3,1;5,13;7,14;3,12;13,1;3,4;3,5;3,10;3,2;7,11;5,2;14,10;6,7;3,12;14,11;15,14;7,13;2,5;4,10;6,3;9,0;4,11;9,8;11,7;3,14;2,9;4,9;5,13;6,12;8,9;1,3;4,4;12,13;0,0;14,7;11,3;7,15;9,11;4,8;7,7]
[n0 n1]=size(obstacle);
%******************����A*�㷨����*********%
t3=clock;
 path1=AStar(obstacle,p);%A*�㷨
 t4=clock;
 A_time=etime(t4,t3)
 [x g]=size(path1);
if length(path1)>=1
%     plot(path1(:,1),path1(:,2),'-+r','LineWidth',2);hold on;
end
%%%%�������·���Ĺյ�*******
%%%%%%����ʵ��ͨ���ĵ�ǰ��б�ʲ�ͬ�ж�
guaidian_x=[];
guaidian_y=[];
for i=2:1:x-1
jude1=(path1(i,2)-path1(i-1,2))/(path1(i,1)-path1(i-1,1));
jude2=(path1(i+1,2)-path1(i,2))/(path1(i+1,1)-path1(i,1));
if jude1~=jude2

  guaidian_x=[guaidian_x;path1(i,1)];
  guaidian_y=[guaidian_y;path1(i,2)];
end
end
% guaidian_x=sort(guaidian_x);
% guaidian_y=sort(guaidian_y);
guaidian=[guaidian_x,guaidian_y];
guaidian=[p.start;guaidian;p.goal]
guaidian=unique(guaidian,'rows')
%legend('A*�㷨�켣');
% %**********���ڸĽ�A_�㷨���˹��Ƴ����İ��˻�����·���滮�о�_���������˹��Ƴ���*******************����%
t1=clock;
[x_num y_num]=size(guaidian);
path_combine=[];
for i=1:1:x_num-1
p.start=guaidian(i,:);
p.goal=guaidian(i+1,:);
Xsum_orgin=[p.goal;obstacle];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%���������(n+1)*2ά������[10 10]��Ŀ��λ�ã�ʣ�µĶ����ϰ���λ�á�
[Goal_orgin time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum_orgin,n0,obstacle)
% [Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum,path1,n0,x,obstacle);
path_combine=[path_combine;Goal_orgin]
end
X1=path_combine(:,1);
Y1=path_combine(:,2);
%����ʱ��
t2=clock;
art_time=etime(t2,t3)
m1=[X1];
N1=[Y1];
plot(m1,N1,'g','LineWidth',2)
% legend('�˹��Ƴ���');
hold on
% hold on
%plot(obstacle(:,1),obstacle(:,2),'o')%,p.goal(1),p.goal(2),'v',p.start(1),p.start(2),'ms',X,Y,'.r');
% legend('Ԥ�趨���','Ԥ�趨�յ�','A*�㷨�켣','�Ľ����ں��㷨','�ϰ���');
% hold on
% title("�˹��Ƴ�����A*�ں��㷨������50���ϰ��������")








%******���øĽ�����ں��㷨��A*���˹��Ƴ����ں��㷨��������
t5=clock;
path_fusion=[];
%%%%�Ľ�
% for i=1:1:x_num-1
% p.start=guaidian(i,:);
% p.goal=guaidian(i+1,:);
% Xsum=[p.goal;obstacle;path1];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%���������(n+1)*2ά������[10 10]��Ŀ��λ�ã�ʣ�µĶ����ϰ���λ�á�
% [Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,p.start,p.goal,Xsum,path1,n0,x,obstacle);
% path_fusion=[path_fusion;Goal]
% end
% %%%��ʼ���ƸĽ����ͼ��
% X=path_fusion(:,1);
% Y=path_fusion(:,2);
Xsum=[goal;obstacle;path1];%[10 10;1 1.2;3 2.5;4 4.5;3 6;6 2;5.5 5.5;8 8.5];%���������(n+1)*2ά������[10 10]��Ŀ��λ�ã�ʣ�µĶ����ϰ���λ�á�
[Goal time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,start,goal,Xsum,path1,n0,x,obstacle);
%%%��ʼ���ƸĽ����ͼ��
X=Goal(:,1);
Y=Goal(:,2);
t6=clock;
fusion_time=etime(t6,t5)+A_time
m=[X];
N=[Y];
plot(m,N,'-b','LineWidth',2)
%legend('�Ľ����ں��㷨');
%legend('Fusion algorithm');
hold on
plot(obstacle(:,1),obstacle(:,2),'o')%,p.goal(1),p.goal(2),'v',p.start(1),p.start(2),'ms',X,Y,'.r');
%legend('�˹��Ƴ���','Ԥ�趨���','Ԥ�趨�յ�','A*�㷨�켣','�Ľ����ں��㷨','�ϰ���');
plot(start(1),start(2),'*r','LineWidth',2);hold on;
plot(goal(1),goal(2),'*b','LineWidth',2);hold on;

legend('Reference method [6] ','Fusion algorithm proposed in this paper','Obstacles','Starting point','Terminal point');
hold on
%title("�˹��Ƴ�����A*�ں��㷨������50���ϰ��������")
% title("Artificial potential field method and A-star fusion algorithm")
FontSize = 25;
set(gca,'FontSize',FontSize);
xlabel('x axis')
ylabel('y axis')

%%%%%������Ҫ�������ɵ�·������
%�����˹��Ƴ���·������
N1=size(X1)
art_length=0;
for i=1:1:(N1-1)
   art_length=art_length+((X1(i,1)-X1(i+1,1))^2+(Y1(i,1)-Y1(i+1,1))^2)^(1/2);
end
disp(['�ο������˹��Ƴ����ĳ���',art_length])
%����A*��·������
N2=size(path1)
A_length=0;
for i=1:1:(N2-1)
   A_length=A_length+((path1(i,1)-path1(i+1,1))^2+(path1(i,2)-path1(i+1,2))^2)^(1/2);
end
disp(['A*�㷨�ĳ���',A_length])

%�ں��㷨��·������
N3=size(X)
Fusion_length=0;
for i=1:1:(N3-1)
   Fusion_length=Fusion_length+((X(i,1)-X(i+1,1))^2+(Y(i,1)-Y(i+1,1))^2)^(1/2);
end
disp(['�ں��㷨�ĳ���',Fusion_length])