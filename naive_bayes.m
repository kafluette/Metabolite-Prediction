% attempt with naive bayes
clear all;
partition_data = true;
center_data = true;
run common;

% train naive bayes
nb = NaiveBayes.fit(data.train.x,data.train.t);
y = nb.predict(data.test.x);
[cmat,order] = confusionmat(data.test.t,y)