%%%%%%子函数：产生新一代个体%%%%%%
function generation()
fitness_order; %计算适应度值及排序
select; %选择操作
crossover;  %交叉
mutation;  %变异