%%%%%%变异%%%%%%
function mutation()
global popsize lchrom mutation_rate temp newpop oldpop
sum=lchrom*popsize;    %总基因个数
mutnum=round(mutation_rate*sum);    %基因发生变异的次数
for i=1:mutnum
s=rem((round(rand*(sum-1))),lchrom)+1; %确定所在基因的位数
t=ceil((round(rand*(sum-1)))/lchrom); %确定变异的是哪个基因
    if t<1
        t=1;
    end
    if t>popsize
        t=popsize;
    end
    if s>lchrom
        s=lchrom;
    end
    if temp(t,s)==1
        temp(t,s)=0;
    else
        temp(t,s)=1;
    end
end
for i=1:popsize
    oldpop(i,:)=temp(i,:);
end
