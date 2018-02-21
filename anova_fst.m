function [anovas] = anova_fst(X_train,Y_train)
%anova_fst Computes F-statistics for big matrices
%   vectorized version of anova, good for feature selection
% expects rows as observations and columns as features
    bg_var = zeros(1,size(X_train,2));
    wg_var =  zeros(1,size(X_train,2));
    grand_means = mean(X_train);
    nconditions = length(unique(Y_train));
    for cond = 1:nconditions
        msk = Y_train==cond;
        sample_means = mean(X_train(msk,:));
        bg_var = bg_var + sum(msk)*((sample_means-grand_means).^2)/(nconditions-1); %between-group variance
        samples = X_train(msk,:);
        wg_var = wg_var + sum((samples-sample_means).^2)/(length(Y_train)-nconditions); %within-group variance
    end
    anovas = bg_var./wg_var;
end

