function [flag]=isObstacle(m,obstacle)
for io=1:length(obstacle(:,1))
    if isSamePosi(obstacle(io,:),m(1:2))
        flag=true;
        return;
    end
end
flag=false;
end
% 判断当前点是否与障碍物重合