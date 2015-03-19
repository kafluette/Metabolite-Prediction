function yfit = predfun_nnet(xtrain,ytrain,xtest)
nodes = 50;
layers = 1;
net_size = repmat(nodes,1,layers);

net = feedforwardnet(net_size);
net = train(net,xtrain,ytrain);
yfit = net(xtest);