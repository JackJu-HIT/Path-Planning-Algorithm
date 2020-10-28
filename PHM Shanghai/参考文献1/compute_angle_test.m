function [Y Xsum_test]=compute_angle_test(X,Xsum,n,x)%Y是引力，斥力与x轴的角度向量,X是起点坐标，Xsum是目标和障碍的坐标向量,是(n+1)*2矩阵
% w=0;  
i=1;
  for w=(n+2):1:(1+n+x)
   r=(X(1)-Xsum(w,1))^2+(X(2)-Xsum(w,2))^2;
   r=sqrt(r);
   if (r<5)&&(-X(1)+Xsum(w,1)>0)
     deltaX(w)=Xsum(w,1)-X(1);
      deltaY(w)=Xsum(w,2)-X(2);
      r(w)=sqrt(deltaX(w)^2+deltaY(w)^2);
      if deltaX(w)>0
          theta=acos(deltaX(w)/r(w));
      else
          theta=pi-acos(deltaX(w)/r(w));
      end
      Y(i)=theta;
      Xsum_test(i,1)=Xsum(w,1);
      Xsum_test(i,2)=Xsum(w,2);
      flag=1;
      i=i+1;
%        break;
   end     
  end
end