%%%����������֤�����յ�����߾����ϰ���ĵ�%%%%%
function  [line_obstacle]=test_if_pass_obstacle(start,goal,MAP)
%%����ֱ�ߺ������̣�������ϰ���
if start==goal
    disp("��ʼ����յ�����겻���غϣ����������ò��ٴγ������г���");
end
[n0 n1]=size(MAP);
j=1;
for i=1:1:n0
    for k=1:1:n1
   if(MAP(i,k)==1)
   a=i-start(2);
   b=(k-start(1))*(goal(2)-start(2))/(goal(1)-start(1));
   if a==b
       line_obstacle(j,1)=k;
       line_obstacle(j,2)=i;
       j=j+1;
   end
   end
       
    end
end
%%%ȥ���ظ�����Ԫ������
line_obstacle=unique(line_obstacle,'rows'); 
end