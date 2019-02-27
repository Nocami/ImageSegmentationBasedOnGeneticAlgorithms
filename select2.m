%%%%%子函数：精英选择%%%%%%
function select()
global fitness popsize oldpop temp popsize1 oldpop1 gen b b1 fitness1

% for i=1:popsize
%     temp(i,:)=oldpop(i,:);
% end
fitnesssum=0;
for i=1:popsize
    fitnesssum = fitnesssum+fitness(1,i);
end

for j =1:popsize
    selectrate(1,j)=fitness(1,j)/double(fitnesssum);
end
q=cumsum(selectrate);

for k=1:popsize
   r=rand;
   tmp=find(r<=q);
   temp(i,:)=oldpop(tmp(1),:);
end    





