function  [Goal_orgin  time_orgin]=arterfical(k,K,m,Po,w,n,a,l,J,start,goal,Xsum,n0,obstacle)
p.start=start;
p.goal=goal;
x=0;
Xj=p.start;%Xo;%j=1ѭ����ʼ����������ʼ���긳��Xj
for j=1:J%ѭ����ʼ
    Goal_orgin(j,1)=Xj(1);%Goal�Ǳ��泵�߹���ÿ��������ꡣ�տ�ʼ�Ƚ����Ž���������
    Goal_orgin(j,2)=Xj(2);
%���ü���Ƕ�ģ��
  [ Theta] =compute_angle(Xj,Xsum,n0,x);%Theta�Ǽ�������ĳ����ϰ�����Ŀ��֮�����X��֮��ļнǣ�ͳһ�涨�Ƕ�Ϊ��ʱ�뷽�������ģ����Լ��������
%���ü�������ģ��
   Angle1=Theta(1);%Theta��1���ǳ���Ŀ��֮��ĽǶȣ�Ŀ��Գ���������
%    if w ~=0
%    Angle2=Theta(n0+1);%Theta��1���ǳ���A*·����֮��ĽǶȣ�Ŀ��Գ���������
%     [Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle1,Angle2,0,Po,n0,w);%�����Ŀ��Գ���������x,y�������������
%    else 
     [Fatx,Faty]=compute_Attract1(Xj,Xsum,k,Angle1,0,Po,n0);   
%    end
   angle_at=Theta(1);%Ϊ�˺��������������������ķ�����ֵ��angle_at
  % [Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle1,Angle2,0,Po,n,w);%�����Ŀ��Գ���������x,y�������������ֵ��
   
    for i=1:n0
       angle_re(i)=Theta(i+1);%��������õĽǶȣ��Ǹ���������Ϊ��n���ϰ�������n���Ƕȡ�
     end
%���ü������ģ��
    [Frerxx,Freryy,Fataxx,Fatayy]=compute_repulsion(Xj,Xsum,m,angle_at,angle_re,n0,Po,a);%�����������x,y����ķ������顣
%��������ͷ����������⣬Ӧ��������ÿ��jѭ����ʱ������Ĵ�СӦ����һ��Ψһ�������������顣Ӧ�ðѳ��������з�����ӣ��������з�����ӡ�
    Fsumyj=Faty+Freryy+Fatayy;%y����ĺ���
    Fsumxj=Fatx+Frerxx+Fataxx;%x����ĺ���
    Position_angle(j)=atan(Fsumyj/Fsumxj);%������x�᷽��ļн�����
%���㳵����һ��λ��
    Xnext(1)=Xj(1)+l*cos(Position_angle(j));
    Xnext(2)=Xj(2)+l*sin(Position_angle(j));
    %���泵��ÿһ��λ����������
    Xj=Xnext;
    
    %�ж�
    e=sqrt((Xj(1)-Xsum(1,1))^2+abs(Xj(2)-Xsum(1,2))^2);
    if (e<0.1)||(Xj(1)-Xsum(1,1)>0)||((Xj(2)-Xsum(1,2))>0)%(abs||(abs(Xj(2)-Xsum(1,2))<0.1)%��Ӧ����ȫ��ȵ�ʱ�������������ֻ�ǽӽ��Ϳ��ԣ����ڰ���ȫ��ȵ�ʱ���̡�
       K=j;%��¼���������ٴΣ�����Ŀ�ꡣ
       break;
       %��¼��ʱ��jֵ
    end%���������if�����������·���ѭ��������ִ�С�
end%��ѭ������
time_orgin = K;
K=j+1;
Goal_orgin(K,1)=Xsum(1,1);%��·�����������һ���㸳ֵΪĿ��
Goal_orgin(K,2)=Xsum(1,2);
end