%%%����������֤�����յ�����߾����ϰ���ĵ�%%%%%
function  [line_obstacle]=test_if_pass_obstacle(p,obstacle)
%%����ֱ�ߺ������̣�������ϰ���
if p.start(1)==p.goal(1)
    disp("��ʼ����յ�����겻���غϣ����������ò��ٴγ������г���");
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
%%%ȥ���ظ�����Ԫ������
line_obstacle=unique(line_obstacle,'rows'); 
end