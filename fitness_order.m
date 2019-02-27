%%%%%%计算适度值并且排序%%%%%%
function fitness_order()
global lchrom oldpop fitness popsize chrom fit gen C m n  fitness1 yuzhisum cross_rate mutation_rate
global lowsum higsum u1 u2 yuzhi gen oldpop1 popsize1 b1 b yuzhi1 maxgen bestfit bestyuzhi
if popsize>=5
    popsize=ceil(popsize-0.03*gen);
end
%当进化到末期的时候调整种群规模和交叉、变异概率
if gen==round(maxgen/2)  
cross_rate=0.8;            %交叉概率
mutation_rate=0.3;         %变异概率
end
%如果不是第一代则将上一代操作后的种群根据此代的种群规模装入此代种群中
if gen>1   %由大到小重新装入oldpop
    t=oldpop;
    j=popsize1;
    for i=1:popsize
        if j>=1
            oldpop(i,:)=t(j,:);
        end
        j=j-1;
    end
end
%计算适度值并排序
for i=1:popsize
    lowsum=0;
    higsum=0;
    lownum=0;   
    hignum=0;
    chrom=oldpop(i,:);
    c=0;
    %转化为十进制
    for j=1:lchrom
        c=c+chrom(1,j)*(2^(lchrom-j));
    end
    %转化到灰度值
b(1,i)=c*255/(2^lchrom-1);          
    for x=1:m
        for y=1:n
            if C(x,y)<=b(1,i)
            lowsum=lowsum+double(C(x,y)); %统计低于阈值的灰度值的总和
            lownum=lownum+1; %统计低于阈值的灰度值的像素的总个数
            else
            higsum=higsum+double(C(x,y)); %统计高于阈值的灰度值的总和
            hignum=hignum+1; %统计高于阈值的灰度值的像素的总个数
            end
        end
    end
    if lownum~=0
        %u1、u2为对应于两类的平均灰度值
        u1=lowsum/lownum; 
    else
        u1=0;
    end
    if hignum~=0
        u2=higsum/hignum;
    else
        u2=0;
    end   
    %计算适度值
fitness(1,i)=lownum*hignum*(u1-u2)^2; 
end
%如果为第一代，从小往大排序
if gen==1 
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
    for i=1:popsize
        fitness1(1,i)=fitness(1,i);
        b1(1,i)=b(1,i);
        oldpop1(i,:)=oldpop(i,:);
    end
    popsize1=popsize;
%大于一代时进行如下从小到大排序
else 
    for i=1:popsize
        j=i+1;
        while j<=popsize
            if fitness(1,i)>fitness(1,j)
                tempf=fitness(1,i);
                tempc=oldpop(i,:);
                tempb=b(1,i);
                b(1,i)=b(1,j);
                b(1,j)=tempb;
                fitness(1,i)=fitness(1,j);
                oldpop(i,:)=oldpop(j,:);
                fitness(1,j)=tempf;
                oldpop(j,:)=tempc;
            end
            j=j+1;
        end
    end
end 
%对上一代群体进行排序
for i=1:popsize1
    j=i+1;
    while j<=popsize1
        if fitness1(1,i)>fitness1(1,j)
            tempf=fitness1(1,i);
            tempc=oldpop1(i,:);
            tempb=b1(1,i);
            b1(1,i)=b1(1,j);
            b1(1,j)=tempb;
            fitness1(1,i)=fitness1(1,j);
            oldpop1(i,:)=oldpop1(j,:);
            fitness1(1,j)=tempf;
            oldpop1(j,:)=tempc;
        end
        j=j+1;
    end
end
%下边统计每一代中的最佳阈值、最佳适应度值
if gen==1
    fit(1,gen)=fitness(1,popsize);
    yuzhi(1,gen)=b(1,popsize);
else
    yuzhi(1,gen)=b(1,popsize); %每一代中的最佳阈值
    fit(1,gen)=fitness(1,popsize); %每一代中的最佳适应度
end
%下边计算截至此代的历史最佳阈值
if gen==1
    bestfit(1,gen)=fitness(1,popsize);
    bestyuzhi(1,gen)=b(1,popsize);
else
    if fitness(1,popsize)>bestfit(1,gen-1)
        bestfit(1,gen)=fitness(1,popsize);
        bestyuzhi(1,gen)=b(1,popsize);
    else
        bestfit(1,gen)=bestfit(1,gen-1);
        bestyuzhi(1,gen)=bestyuzhi(1,gen-1);
    end
end
