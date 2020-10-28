function path=AStar(obstacle,p)
path=[];%���ڴ洢·��
%OpenList
open=[p.start(1) p.start(2) h(p.start,p.goal) 0 p.start(1) p.start(2)];%�����⣡������������
%CloseList
close=[];
next=MotionModel();%����״̬--��һ���İ˸���
findFlag=false;%Ŀ���־
while ~findFlag
    if isempty(open(:,1)) 
        disp('No path to goal!!');
        return;
    end
    %�ж��Ƿ�ﵽĿ��
%     if isSamePosi(open(1,1:2),p.goal)%%%�Ե�һ�е���̹��ۺ����������յ�����ȶ�
%         disp('Find Goal!!');
%         close=[open(1,:);close]%%�ۼ�֮ǰ�ҵ��Ľ�
%         open(1,:)=[];%%��open list��յ�һ�еĵ㼴�ҵ���Ŀ���
%         findFlag=true;%%%��־λ����ֹwhile��ѭ����
%         break;
%     end 
%�ж�Ŀ����Ƿ������open�б���
    [isopenFlag,Id]=isopen(p.goal,open);
    if isopenFlag
        disp('Find Goal!!');
        close =[open(Id,:);close]
        findFlag=true;
        break;
    end
     [Y,I] = sort(open(:,3))%��OpenList�е���������
    open=open(I,:);    %%�����Ե�����������
    %------------------b.��Fֵ��С�Ľڵ�(��open�е�һ�нڵ�)���ŵ�close��һ��(close�ǲ��ϻ�ѹ��)����Ϊ��ǰ�ڵ�
    close = [open(1,:);close];
    current= open(1,:);%%%ѡ����СFֵ��ǰ�ڵ㣬���쵱ǰ�ڵ�
    open(1,:)=[];%��Ϊ�Ѿ���open���Ƴ��ˣ����Ե�һ����ҪΪ��
    %�ҵ����Ź켣�ŵ�close list����
    
    for in=1:length(next(:,1))
%         m=[open(1,1)+next(in,1) open(1,2)+next(in,2) open(1,3) 0 0 0];%%�ѵ�ǰ���Ѱ��Χ�ĵ㣡����������
%         m(3)=next(in,3)+h(m(1:2),p.goal);%m--Fֵ=f+g������next��in,3�������㵽��ǰ��ľ��룬h(m(1:2),p.goal)Ϊ��Ƿ��ľ��롣
        
        m=[current(1,1)+next(in,1) , current(1,2)+next(in,2) ,0,0,0,0]; 
        m(4)=current(1,4)+next(in,3); % m(4) ���ڽڵ�Gֵ
        m(3)=m(4)+h(m(1:2),p.goal);%m(3)=next(in,3)+h(m(1:2),p.goal);% m(3)  ���ڽڵ�Fֵ
        
        if isObstacle(m,obstacle)%%�������ģ���ֱ������,����ɨ����һ����Χ�ĵ㣬�ϰ����߲��ˣ��Ǿͻ�һ����
            continue;
        end
        %�ж���Χ�ĵ��ڲ���openlist�С������������뵽open list��
        %{
�������ܣ�
������ڽڵ�(m�洢����Ϣ)  �Ѿ���Closelist�У���flag = 1  targetInd = ������close��������������λ
������ڽڵ�(m�洢����Ϣ)    ����Openlist �У���flag = 2  targetInd = []
������ڽڵ�(m�洢����Ϣ)  �Ѿ���Openlist �У���flag = 3  targetInd = ������open��������������λ

%}
        [flag, targetInd]=FindList(m,open,close)
%         if flag==3%1 %��Openlist��
%             disp('�Ѵ���OpenList��')
%             continue;
%         elseif flag==1%2 
%             disp('�Ѵ���CloseList��')
%             continue;
%         else
%             open=[open;[m open(1,1) open(1,2)]]%%%����openlist�� %������%%ÿ��open ��һ�е�һ�к͵�һ�е�һ�ж��ڸ���
%         end
%     end
%     if findFlag==false
%         %��OpenList�еĵ�һ���ƶ���CloseList��
%         close=[close; open(1,:)]
%         open(1,:)=[];
%     end

 %>>�������Closelist�У����Դ����ڽڵ�
        if flag==1 
            continue;
        %>>���������Openlist�У�����Openlist,���ѵ�ǰ�ڵ�����Ϊ���ĸ��ڵ�
        elseif flag==2 
            m(5:6)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
            open=[open;m];%�������ڽڵ�ӷ�openlist��
        %>>ʣ�µ������������Openlist�У�����ɵ�ǰ�ڵ㵽���ڽڵ��Ƿ���ã���������򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������F,Gֵ�����򲻲���    
        else
            %�ɵ�ǰ�ڵ㵽�����ڽڵ����(targetInd�Ǵ����ڽڵ���open�е��кŴ��еĵ�3���Ǵ��ۺ���Fֵ)
            if m(4)<open(targetInd,4) %m(3) < open(targetInd,3)open(targetInd,4)֮ǰ�Ѿ�������
                %���ã��򽫴����ڽڵ�ĸ��ڵ�����Ϊ��ǰ�ڵ㣬����������
                m(5:6)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
                open(targetInd,:)=m;%�������ڽڵ���Openlist�е����ݸ���%%%���Ҫ��ֵ��close
            end
        end
    end
end
path=GetPath(close,p.start);%����·��
end

% ��������������������������������
% ��Ȩ����������ΪCSDN��������������ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/sinat_16910875/article/details/85311819
% ʵ�ֲ���Ϊ��	
% 1������ʼ���Ž�OpenList��
% 2����OpenList�еĵ����У����ۺ���ֵ����������
% 3�����㵱ǰ����Χ�˸����Fֵ��������OpenList��
% 4����OpenList�еĵ�һ���ƶ���CloseList��
%https://blog.csdn.net/sinat_16910875/article/details/85311819
%https://blog.csdn.net/u014795863/article/details/88831920
%%%%%��Ҫ�ο��������https://blog.csdn.net/u014795863/article/details/88831920
% %%%����A*�㷨���岽�����£�
%
% 1�����Ƚ���ʼ����ӽ��������б���
% 2���ظ����²��裺
%    ��a) Ѱ�ҿ����б���Fֵ��͵Ľڵ㡣���ǳ���Ϊ����ǰ�ڵ㡱��
%    ��b) �����ӡ������б����Ƴ�������ӽ����ر��б���
%    ��c) ��顰��ǰ�ڵ㡱�Ƿ��ǡ�Ŀ��ڵ㡱
%       ��* ����ǣ�ֹͣ������������ 3 ����
%       ��* ������ǣ��������沽�衭�� ��
%    ��d) Ѱ�ҡ���ǰ�ڵ㡱�ڽ��Ľڵ�
%       ��* ���������ͨ�������Ѿ��ڹر��б��У��Թ�������֮���¡�
%       ��* ��������ڿ����б��У�������ӽ������б��ѵ�ǰ�ڵ���Ϊ��һ�ڵ�ĸ��ڵ㡣��¼��һ���F,G,��Hֵ��
%       ��* ������Ѿ��ڿ����б��У������·������Gֵ�Ĳ�����Ӱ��
%           ��a. �������Gֵ��Ϊ��·�������ô����ԭ����״̬�������κθı䣻
%           ��b. ���Gֵ��С��˵����·�����ã����丸����Ϊ����ǰ��㡱������G��Fֵ��
%    ��e) ����б��Ƿ�Ϊ�գ����Ϊ�գ�˵��·��δ�ҵ���ֱ�ӷ��أ��������κβ��衣
% 3������·������Ŀ��ڵ㿪ʼ������ÿһ�ڵ�ĸ��ڵ��ƶ�ֱ���ص���ʼ�ڵ㡣���������Ҫ











% A*()
% {
% Open = [��ʼ�ڵ�];
% Closed = [];
% while (Open��ǿ�)
% {
% ��Open��ȡ��һ���ڵ�X������OPEN����ɾ����
% ��  if (X��Ŀ��ڵ�)
% ����{
% ����  ���·��PATH��
% ����  ����·��PATH��
% ����}
% ����for (ÿһ��X���ӽڵ�Y)
% ����{
% if (Y����OPEN���CLOSE����)
% ����  {
%          ��Y�Ĺ���ֵ��
% ����Y����OPEN���У�
% }
% ����  //��û������
% ��    else if (Y��OPEN����)
% ����  {
% if (Y�Ĺ���ֵС��OPEN��Ĺ���ֵ)
% ����OPEN���еĹ���ֵ��
% }
% ����   else //Y��CLOSE����
% ��     {
%          if (Y�Ĺ���ֵС��CLOSE��Ĺ���ֵ)
% ����     {
% ����CLOSE���еĹ���ֵ��
% ��CLOSE�����Ƴ��ڵ㣬������OPEN���У�
% }
% }
% ��X�ڵ����CLOSE���У�
% ���չ���ֵ��OPEN���еĽڵ�����
% }//end for
% ��}   //end while
% }     //end functi
% ��������������������������������
% ��Ȩ����������ΪCSDN�������޼�ɽ�����ӡ���ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/autonavi2012/article/details/80923431