% attempt with discriminant analysis
clear all;
partition_data = true;
center_data = false;
run common;

% train classifier
mdl = ClassificationDiscriminant.fit(data.all.x,data.all.t,...
    'discrimtype','quadratic',...
    'savememory','on','fillcoeffs','off');
    
mdl_loss = resubLoss(mdl)

cvmdl = mdl.crossval('cvpartition',data.cp);
cvmdl_loss = kfoldLoss(cvmdl)

% can only be enabled when doing linear discriminate
% [err,gamma,delta,npred] = cvshrink(mdl,'numgamma',29,...
%     'numdelta',29,'verbose',1);
% figure;
% plot(err,npred,'k.')
% xlabel('Error rate');
% ylabel('Number of predictors');