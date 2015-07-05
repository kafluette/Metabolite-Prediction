% attempt with neural net
clear all;
partition_data = false;
run common;

t = zeros(size(data.all.t,1),2);
t(find(data.all.t==1,1)) = 1;
t(find(data.all.t==0,2)) = 1;

cv_mcr = crossval('mcr',data.all.x,data.all.t,'predfun',@predfun_nnet)