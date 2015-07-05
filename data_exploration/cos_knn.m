% attempt with knn using cosine similarity
clear all;
partition_data = false;
center_data = false;
run common;

cv_mcr = crossval('mcr',data.all.x,data.all.t,'predfun',@predfun_cos_knn)