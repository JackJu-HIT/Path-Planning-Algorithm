function obstacle=GetObstacle(n0bstacle,p)
nob=n0bstacle;
obstacle=[];%�޸ĺ�
ob=round(rand([nob,2])*p.XYMAX);%%%rand([nob,2])��ʾnob��2�е�С��1�ľ���
removeInd=[];
for io=1:length(ob(:,1))
   if(isSamePosi(ob(io,:),p.start))||(isSamePosi(ob(io,:),p.goal))%%%������ϰ�������ʼ������յ��غϣ���ɾ����
        removeInd=[removeInd;io];
   end  
end
ob(removeInd,:)=[];   %%%����Ŀ��������غϵĵ�ɾ������Ϊ���ǲ����ϰ���
obstacle=[obstacle;ob];%%%ȥ�����ص���ϰ������ꡣ
end

% ��������������������������������
% ��Ȩ����������ΪCSDN��������������ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/sinat_16910875/article/details/85311819
% ��õ�ͼ�е��ϰ���