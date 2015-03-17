% attempt with knn using cosine similarity
clear all;
partition_data = true;
center_data = false;
run common;

% train classifier
mdl = ClassificationKNN.fit(data.all.x,data.all.t,...
    'distance','cosine','numneighbors',4,...
    'distanceweight','squaredinverse');
cvmdl = mdl.crossval('cvpartition',data.cp);
cvmdl_loss = kfoldLoss(cvmdl)
bin = mean(data.all.x); % an average bin
bin_y = mdl.predict(bin)