%%%%������������Ѱ�ţ�f=g+B*h���е�Bֵ%%%%%
clear all;
improved_length=[];
TA_length=[];
STEP_IM_TIME=[];
STEP_TA_TIME=[];
result_IM=[];
RESULT_TA=[];
for value_B=1:1:50
     [a b]=search_Connecting_Distance(value_B);
     improved_length=[improved_length a];
end
% filename=['E:\�о��������ļ���\�ڿ�����\�ڿ�����\����\IMPROVED\',['Improve_Time_Value_B=',num2str(value_B)],'.txt'];
%  dlmwrite(filename, improved_length,'delimiter','\t','newline','pc');
 filename=['E:\�о��������ļ���\�ڿ�����\���濪ʼ\����\��search_Connecting_DistanceѰ������\','IM_Connecting_Distance_LENGTH','.txt'];
 dlmwrite(filename, improved_length','delimiter','\t','newline','pc');
% filename=['E:\�о��������ļ���\�ڿ�����\�ڿ�����\����\RESULT\','TA_AVER','.txt'];
%  dlmwrite(filename, result_TA,'delimiter','\t','newline','pc');