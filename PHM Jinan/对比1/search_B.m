%*******�����׶θĽ�A*�㷨������***********%%%
function [improved_length TA_length A_time TA_time]=search_B(value_B)
%  value_B=1;
% clear all
disp('A Star Path Planing start!!') 
p.start=[1 1];  %��ʼ��
p.goal=[40 40];  %Ŀ���
p.XYMAX=40; %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
obstacle=GetBoundary(p);%�õ��߽�����
nObstacle=100;%�ڵ�ͼ���������20���ϰ���
obstacle=GetObstacle(nObstacle,p)%�ϰ���ͱ߽�
%�յ�����Ϊ��40,40��ʱ������˺ܶ� ����·������С��
obstacle=[20,11;20,22;35,39;14,29;18,34;39,17;2,19;39,22;8,8;27,30;23,20;27,26;14,12;25,6;32,19;1,14;3,32;39,31;26,27;9,5;16,1;5,22;11,11;10,38;13,39;6,11;20,20;5,36;35,24;4,35;37,38;16,22;2,29;14,23;29,1;32,18;22,26;27,21;36,15;2,37;12,33;2,34;8,15;29,24;29,35;35,37;23,27;3,8;37,26;32,3;28,27;28,29;25,26;25,24;21,20;;15,16;15,14;]
%�յ�����Ϊ��20,20�� ����ʱ��ӳ��� ��·�����ȶ���
%obstacle=[19,2;20,18;1,10;10,12;17,6;5,2;17,17;16,3;13,7;0,12;8,20;18,10;14,20;8,5;13,8;5,14;11,1;20,15;17,8;6,16;14,8;7,6;2,14;5,8;16,2;2,15;11,13;16,1;15,2;3,20;9,10;7,0;10,1;12,3;3,18;18,9;13,11;3,10;11,1;19,18;16,6;14,5;9,12;5,10;11,7;5,13;6,19;18,12;18,6;16,4;19,9;4,1;10,18;13,12;18,4;13,10;8,1;15,17;16,9;12,11;2,11;18,14;1,7;11,2;2,9;8,1;16,15;5,1;18,19;14,15;8,19;5,10;5,5;15,5;1,15;14,20;12,7;15,15;20,2;8,12;5,9;18,15;16,5;9,2;2,9;11,13;4,3;11,9;7,13;6,17;15,6;10,8;16,18;4,14;14,5;1,15;16,6;14,6;19,0]
[n0 n1]=size(obstacle);
path3=[];
%%%%%�Ľ�ǰ�������ġ��Ľ�A_�㷨��AGV·���滮_����ΰ���Ľ�A*�㷨������A*�㷨************
 t1=clock;
[ path3 STEP_TA_TIME]=AStar_referance(obstacle,p,1);%A*�㷨
 t2=clock;
 TA_time=etime(t2,t1);
 
 [x g]=size(path3);
%  %%����β��Գ���
% %  obstacle=[2.5,5;6,12;8,16]
% % path3=[1,2;2,4;3,6;4,8;5,10;9,18;10,20;11,22];
% % 
% %  TA_time=etime(t2,t1);
% %%%%%%
% col_num=[];
%  k=1;
% for i=1:1:x
%     for j=(k+2):1:x
%     [value]=detect_obstacle(path3(k,:),path3(j,:),obstacle)
%     if value==0
%     %%%��¼Ҫɾ�����к�
%     c=j-1;
%     col_num=[col_num,c];
%     else
%         k=j
%         break;
%     end
%     end
% %     if j==x
% %         break;
% %     end
% end
% %%%%����col_numɾ�����������
% % d=col_num;
% % b=cumsum(path);
% col_num=unique(col_num','rows'); 
% d=col_num';
% [n11,n12]=size(path3)
% path2=[];
% for i=1:1:n11
%     [a]=is_same_num(i,d')
%     if a==0   
%      path2=[path2;path3(i,:)];
%     end
% end
% path3=path2;
%  
%  
%  
figure 
plot(p.start(1),p.start(2),'*r','LineWidth',2);hold on;
plot(p.goal(1),p.goal(2),'*b','LineWidth',2);hold on;
%title('Comparison of A star algorithm before and after improvement');
if length(path3)>=1
    plot(path3(:,1),path3(:,2),'-r','LineWidth',2);hold on;
end
hold on



%%%%*****��֤��ֱ�ߴ������ϰ���ĵ�%%

t3=clock;
line_obstacle=[];
[line_obstacle]=test_if_pass_obstacle(p,obstacle);
% t8=clock;
% A_time_test1=etime(t8,t3);

%�����߶����ϰ��������յ㴦��
 r=0.5;
 path_line_start_ago=[];
  path_line_goal_ago=[];
 [path_line_start_ago path_line_goal_ago]=solve_line_circle(r,line_obstacle,p)
%  t9=clock;
 %%%�����ɺ�ľ��������յ���кϲ�
  path_line_start=[];
  path_line_goal=[];
 path_line_start=path_line_start_ago;
 path_line_goal=path_line_goal_ago;
 [N9 N10]=size(path_line_start)
 new_start_x=[];
 new_start_y=[];
 new_goal_x=[];
 new_goal_y=[];
 N=1;
%  if N9==1
%     return;
 for i=1:1:N9-1
     if N9==1
         break;
     end
    if path_line_goal(i,1)==path_line_start(i+1,1)&&path_line_goal(i,2)==path_line_start(i+1,2)
        %�ȴ��
        new_start_x=[new_start_x;path_line_start(i,1)];
        new_start_y=[new_start_y;path_line_start(i,2)];
        new_goal_x=[new_goal_x;path_line_goal(i+1,1)];
        new_goal_y=[new_goal_y;path_line_goal(i+1,2)];
        %�޸�ԭ�Ĵ�����������Ĵ���
        path_line_start(i+1,1)=path_line_start(i,1);
    elseif i==N9-1
        new_start_x=[new_start_x;path_line_start(i,1);path_line_start(i+1,1)];
        new_start_y=[new_start_y;path_line_start(i,2);path_line_start(i+1,2)];
        new_goal_x=[new_goal_x;path_line_goal(i,1);path_line_goal(i+1,1)];
        new_goal_y=[new_goal_y;path_line_goal(i,2);path_line_goal(i+1,2)];
    else 
        new_start_x=[new_start_x;path_line_start(i,1)];
        new_start_y=[new_start_y;path_line_start(i,2)];
        new_goal_x=[new_goal_x;path_line_goal(i,1)];
        new_goal_y=[new_goal_y;path_line_goal(i,2)];
    end
 end
 %%���new�Ƿ���Ҫ���� 
[N11 N12]=size(new_start_x)
if N11>0
    path_line_start_ago=[new_start_x,new_start_y];
    path_line_goal_ago=[new_goal_x,new_goal_y]
end
Goal=[];
STEP_TIME=[];
[Goal  STEP_IM_TIME]=deal_line_obstacle(obstacle,path_line_start_ago,path_line_goal_ago,p,value_B)
t10=clock;
%  A_time=etime(t10,t9);
%   path=AStar(obstacle,p);%A*�㷨
Goal1=[];
Goal1=unique(Goal,'rows'); 


t4=clock;
A_time=etime(t4,t3);
X=Goal1(:,1);
Y=Goal1(:,2);
m=[X];
N=[Y];
plot(m,N,'b','LineWidth',2)
hold on
%���Ƶ�ͼ�ϰ�������յ�
plot(obstacle(:,1),obstacle(:,2),'o')%,p.goal(1),p.goal(2),'v',p.start(1),p.start(2),'ms',X,Y,'.r');
% figure(1)
% legend('Ԥ�趨���','Ԥ�趨�յ�','A*�㷨�Ľ�ǰ�켣','A*�㷨�Ľ����㷨','�ϰ���');
legend('Starting point','Terminal point','Traditional A-star algorithm','Improved A-star algorithm','Obstacles');


FontSize = 15;
set(gca,'FontSize',FontSize);
xlabel('x axis')
ylabel('y axis')



%����Ľ�ǰA*��·������
N2=size(path3)
TA_length=0;
for i=1:1:(N2-1)
   TA_length=TA_length+((path3(i,1)-path3(i+1,1))^2+(path3(i,2)-path3(i+1,2))^2)^(1/2);
end
disp(['A*�㷨�Ľ�ǰ�ĳ���',TA_length])

%�ں��㷨��·������
N3=size(X)
A_length=0;
for i=1:1:(N3-1)
   A_length=A_length+((X(i,1)-X(i+1,1))^2+(Y(i,1)-Y(i+1,1))^2)^(1/2);
end
%disp(['A*�㷨�ĺ�ĳ���',A_length])
improved_length=vpa(A_length)
end