% attempt with neural net
clear all;
run common;

% train net
net = patternnet(net_layers);
net = configure(net,data.all.x',data.all.t');
[net,tr] = train(net,data.all.x',data.all.t');
nntraintool
