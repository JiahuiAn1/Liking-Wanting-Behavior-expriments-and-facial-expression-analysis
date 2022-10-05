%p=ceil(rand*10)
Y = [];
N_total=20 % number of all the food items
N_choose=10 % number of to be presented food items
while size(Y,1) ~= N_choose
Y = unique([Y ; randsample(N_total,1)'],'rows');
end;
Y = Y(randperm(size(Y,1)),:) 