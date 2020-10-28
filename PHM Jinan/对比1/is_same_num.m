 function [flag]=is_same_num(g,d)
% d=[2,3,4,5,6,7,8,9,10,11,12,13]'
[n1 n2]=size(d);
flag=0;
for i=1:1:n1
    if d(i,1)==g
        flag=1;
        break;
    end
end
 end