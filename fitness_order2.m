%%%%%%计算适度值%%%%%%
function fitness_order()
global lchrom oldpop fitness popsize chrom fit gen C m n  fitness1 yuzhisum cross_rate mutation_rate
global lowsum higsum u1 u2 yuzhi gen oldpop1 popsize1 b1 b yuzhi1 bestyuzhi bestfit

%计算适度值
for i=1:popsize
    lowsum=0;
    higsum=0;
    lownum=0;
    hignum=0;
    chrom=oldpop(i,:);
    c=0;
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
