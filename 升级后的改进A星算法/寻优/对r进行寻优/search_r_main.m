%%%%主函数，用于寻优（f=g+B*h）中的B值%%%%%
clear all;
improved_length=[];
TA_length=[];
STEP_IM_TIME=[];
STEP_TA_TIME=[];
result_IM=[];
RESULT_TA=[];
for value_B=1:0.1:50
     [a b]=search_r(value_B);
     improved_length=[improved_length a];
end
% filename=['E:\研究生工作文件夹\期刊论文\期刊论文\数据\IMPROVED\',['Improve_Time_Value_B=',num2str(value_B)],'.txt'];
%  dlmwrite(filename, improved_length,'delimiter','\t','newline','pc');
 filename=['E:\研究生工作文件夹\期刊论文\仿真开始\数据\对r寻优数据结果\','IM_R_LENGTH','.txt'];
 dlmwrite(filename, improved_length','delimiter','\t','newline','pc');
% filename=['E:\研究生工作文件夹\期刊论文\期刊论文\数据\RESULT\','TA_AVER','.txt'];
%  dlmwrite(filename, result_TA,'delimiter','\t','newline','pc');