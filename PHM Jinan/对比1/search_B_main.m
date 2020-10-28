%%%%主函数，用于寻优（f=g+B*h）中的B值%%%%%
clear all;
improved_length=[];
TA_length=[];
STEP_IM_TIME=[];
STEP_TA_TIME=[];
for value_B=0:0.2:2
     [a b c d]=search_B(value_B);
     improved_length=[improved_length a];
     TA_length=[TA_length b];
     STEP_IM_TIME=[STEP_IM_TIME c];
     STEP_TA_TIME=[STEP_TA_TIME d];
end
%  [a b]=search(1,1);