function yfit = predfun_nb(xtrain,ytrain,xtest)
nb = NaiveBayes.fit(xtrain,ytrain);
yfit = nb.predict(xtest);