function [Y]=compute_angle(X,Xsum,n,x)%Y��������������x��ĽǶ�����,X��������꣬Xsum��Ŀ����ϰ�����������,��(n+1)*2����
w=0;  
for i=1:n+1%n���ϰ���Ŀ
      deltaX(i)=Xsum(i,1)-X(1);
      deltaY(i)=Xsum(i,2)-X(2);
      r(i)=sqrt(deltaX(i)^2+deltaY(i)^2);
      if deltaX(i)>0
          theta=acos(deltaX(i)/r(i));
      else
          theta=pi-acos(deltaX(i)/r(i));
      end
      if i==1%��ʾ��Ŀ��  �ⲽ��Ҫ�ǿ��ǵ�angle���������˳���ÿ���Ƕ���Y�������棬��һ��Ԫ������Ŀ��ĽǶȣ����涼�����ϰ��ĽǶ�
          angle=theta;
      else
          angle=theta;
      end     
      Y(i)=angle;%����ÿ���Ƕ���Y�������棬��һ��Ԫ������Ŀ��ĽǶȣ����涼�����ϰ��ĽǶ�
end
% i=1;
%   for w=(n+2):1:(1+n+x)
%    r=(X(1)-Xsum(w,1))^2+(X(2)-Xsum(w,2))^2;
%    r=sqrt(r);
%    if (r<4)&&(-X(1)+Xsum(w,1)>0)
%      deltaX(w)=Xsum(w,1)-X(1);
%       deltaY(w)=Xsum(w,2)-X(2);
%       r(w)=sqrt(deltaX(w)^2+deltaY(w)^2);
%       if deltaX(w)>0
%           theta=acos(deltaX(w)/r(w));
%       else
%           theta=pi-acos(deltaX(w)/r(w));
%       end
%       Y(n+2)=theta;
%       Xsum_test(i,1)=Xsum(w,1);
%       Xsum_test(i,2)=Xsum(w,2);
%       i=i+1;
%       n=n+1;
%        break;
%    end     
end