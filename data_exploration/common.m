% constants
if ~exist('holdout_pct','var')
    holdout_pct = 0.1;       % validation pct
end
if ~exist('net_layers','var')
    net_layers  = 10;        % # layers in nnet
end
if ~exist('prune_data','var')
    prune_data  = inf;       % shrink dataset? set to inf to not
end
if ~exist('partition_data','var')
    partition_data = false;  % provide paritioned train and test sets?
end
if ~exist('center_data','var')
    center_data = true;      % center data by default
end

% load data
pos = csvread('Tyrosine/positive_train.csv',1,0);   % load positive
pos(:,end+1) = true;                                   % add label
if prune_data ~= inf                                   % if size given
    pos = pos(1:prune_data,:);                         % slim down
end
neg = csvread('Tyrosine/negative_train.csv',1,0);   % load negatives
neg(:,end+1) = false;                                  % add label
if prune_data ~= inf                                   % if size given
    neg = neg(1:prune_data,:);                         % slim down
end
all = [pos; neg];                                      % merge samples
[n,d] = size(all);                                     % get n, d for later
all = all(randperm(n),:);                              % shuffle rows
if center_data
    all(:,end-1) = zscore(all(:,end-1));               % center data
end

data = {};
data.all = {};
data.all.x = all(:,1:end-1);
data.all.t = all(:,end);

% partition data
if partition_data
    c = cvpartition(n,'holdout',holdout_pct);   % parition indices
    data.cp = c;
    data.train = {};                            % training data
    data.train.x = all(c.training,1:end-1);     %   inputs
    data.train.t = all(c.training,end);         %   target
    data.test = {};                             % testing data
    data.test.x = all(c.test,1:end-1);          %   inputs
    data.test.t = all(c.test,end);              %   target
end

clear('pos','neg','all');
