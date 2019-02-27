%%%%%%交叉%%%%%%
function crossover()
global temp popsize cross_rate lchrom
j=1;
for i=1:popsize
    p=rand;
    if p<cross_rate
        parent(j,:)=temp(i,:);
        a(1,j)=i;%整个群体中第几个即将交叉的个体
        j=j+1;
    end
end
j=j-1;
if rem(j,2)~=0
    j=j-1;
end
if j>=2
    for k=1:2:j
        cutpoint=round(rand*(lchrom-1));
        f=k;
        for i=1:cutpoint %将交叉点之前的值存入temp
            temp(a(1,f),i)=parent(f,i);
            temp(a(1,f+1),i)=parent(f+1,i);
        end
        for i=(cutpoint+1):lchrom
            temp(a(1,f),i)=parent(f+1,i);
            temp(a(1,f+1),i)=parent(f,i);
        end
    end
end
