%%%%%子函数：精英选择%%%%%%
function select()
global fitness popsize oldpop temp popsize1 oldpop1 gen b b1 fitness1
%统计前一个群体中适应值比当前群体适应值大的个数
s=popsize1+1;
for j=popsize1:-1:1
    if fitness(1,popsize)<fitness1(1,j)
        s=j;
    end
end
for i=1:popsize
    temp(i,:)=oldpop(i,:);
end
if s~=popsize1+1
    %小于50代用上一代中用适应度值大于当前代的个体随机代替当前代中的个体
    if gen<50  
        for i=s:popsize1
            p=rand;
            j=floor(p*popsize+1);
            temp(j,:)=oldpop1(i,:);
            b(1,j)=b1(1,i);
            fitness(1,j)=fitness1(1,i);
        end
    else
    %50~100代用上一代中用适应度值大于当前代的个体代替当前代中的最差个体
    if gen<100  
            j=1;
            for i=s:popsize1
                temp(j,:)=oldpop1(i,:);
                b(1,j)=b1(1,i);
                fitness(1,j)=fitness1(1,i);
                j=j+1;
            end
    %大于100代用上一代中的优秀的一半代替当前代中的最差的一半，加快寻优
    else 
            j=popsize1;
            for i=1:floor(popsize/2)
                temp(i,:)=oldpop1(j,:);
                b(1,i)=b1(1,j);
                fitness(1,i)=fitness1(1,j);
                j=j-1;
            end
     end
    end
end
%将当前代的各项数据保存
for i=1:popsize
    b1(1,i)=b(1,i); 
end    
for i=1:popsize
    fitness1(1,i)=fitness(1,i); 
end
for i=1:popsize
    oldpop1(i,:)=temp(i,:);
end
popsize1=popsize;
