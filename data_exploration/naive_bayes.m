% attempt with naive bayes
clear all;
partition_data = false;
center_data = true;
run common;

cv_mcr = crossval('mcr',data.all.x,data.all.t,'predfun',@predfun_nb)