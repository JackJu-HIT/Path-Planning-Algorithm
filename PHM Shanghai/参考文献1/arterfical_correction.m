%**********�ںϺ���㷨**********%
function  [Goal  time]=arterfical_correction(k,K,m,Po,w,n,a,l,J,start,goal,Xsum,path1,n0,x,obstacle)
p.start=start;
p.goal=goal;
Xj=p.start;%Xo;%j=1ѭ����ʼ����������ʼ���긳��Xj
for j=1:J%ѭ����ʼ
    Goal(j,1)=Xj(1);%Goal�Ǳ��泵�߹���ÿ��������ꡣ�տ�ʼ�Ƚ����Ž���������
    Goal(j,2)=Xj(2);
%���ü���Ƕ�ģ��
  [ Theta] =compute_angle(Xj,Xsum,n0,x);%Theta�Ǽ�������ĳ����ϰ�����Ŀ��֮�����X��֮��ļнǣ�ͳһ�涨�Ƕ�Ϊ��ʱ�뷽�������ģ����Լ��������
%���ü�������ģ��
%%%�ж��Ƿ��п��õ�·����
 for w=(n0+2):1:(1+n0+x)
   r=(Xj(1)-Xsum(w,1))^2+(Xj(2)-Xsum(w,2))^2;
   r=sqrt(r);
   if (r<5)&&(-Xj(1)+Xsum(w,1)>0)
     [Theta2 Xsum_test]=compute_angle_test(Xj,Xsum,n0,x);
     w=1;
   end
 end
    

% w=0;
%     [n6 n7]=size(Theta);
%     n6
%     if n6>(n+1)
%         w=1;
%         for ir=1:1:(n6-n-1)
%             Theta2(ir)=Theta(ir+n+1);
%         end
%     end
   Angle1=Theta(1);%Theta��1���ǳ���Ŀ��֮��ĽǶȣ�Ŀ��Գ���������
   if w ~=0
%        [n4 n5]=size(Theta)
    Angle2=Theta2;%Theta��1���ǳ���A*·����֮��ĽǶȣ�Ŀ��Գ���������
    [Fatx,Faty]=compute_Attract(Xj,Xsum,Xsum_test,k,Angle1,Angle2,0,Po,n0,w);%�����Ŀ��Գ���������x,y�������������
   else 
     [Fatx,Faty]=compute_Attract1(Xj,Xsum,k,Angle1,0,Po,n0);   
   end
   w=0;
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
time=K;
K=j+1;
Goal(K,1)=Xsum(1,1);%��·�����������һ���㸳ֵΪĿ��
Goal(K,2)=Xsum(1,2);
end