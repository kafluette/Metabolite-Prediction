function yfit = predfun_cos_knn(xtrain,ytrain,xtest)
mdl = ClassificationKNN.fit(xtrain,ytrain,...
    'distance','cosine','numneighbors',4,...
    'distanceweight','squaredinverse');
yfit = mdl.predict(xtest);