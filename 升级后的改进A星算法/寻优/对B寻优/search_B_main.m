%%%%������������Ѱ�ţ�f=g+B*h���е�Bֵ%%%%%
clear all;
improved_length=[];
TA_length=[];
STEP_IM_TIME=[];
STEP_TA_TIME=[];
result_IM=[];
RESULT_TA=[];
for value_B=0:0.01:5
%      value_B=5
     [a b]=search_B(value_B);
     improved_length=[improved_length a];
end
% filename=['E:\�о��������ļ���\�ڿ�����\�ڿ�����\����\IMPROVED\',['Improve_Time_Value_B=',num2str(value_B)],'.txt'];
%  dlmwrite(filename, improved_length,'delimiter','\t','newline','pc');
 filename=['E:\�о��������ļ���\�ڿ�����\���濪ʼ\����\��BѰ�����ݽ��\','IM_B_LENGTH','.txt'];
 dlmwrite(filename, improved_length','delimiter','\t','newline','pc');
% filename=['E:\�о��������ļ���\�ڿ�����\�ڿ�����\����\RESULT\','TA_AVER','.txt'];
%  dlmwrite(filename, result_TA,'delimiter','\t','newline','pc');