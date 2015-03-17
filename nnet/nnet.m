% reset space
clear all;

% constants
holdout_pct = 0.3;       % train percent
net_layers  = 10;        % # layers in nnet
prune_data  = inf;        % shrink dataset? set to inf to not

% load data
pos = csvread('../Tyrosine/positive_train.csv',1,0);   % load positive
pos(:,end+1) = true;                                   % add label
if prune_data ~= inf                                   % if size given
    pos = pos(1:prune_data,:);                         % slim down
end
neg = csvread('../Tyrosine/negative_train.csv',1,0);   % load negatives
neg(:,end+1) = false;                                  % add label
if prune_data ~= inf                                   % if size given
    neg = neg(1:prune_data,:);                         % slim down
end
all = [pos; neg];                                      % merge samples
[n,d] = size(all);                                     % get n, d for later
all = all(randperm(n),:);                              % shuffle rows
all(:,end-1) = zscore(all(:,end-1));                   % center data

% train net
x = all(:,1:end-1)';
t = all(:,end)';
net = patternnet(net_layers);
net = configure(net,x,t);
[net,tr] = train(net,x,t);
nntraintool
