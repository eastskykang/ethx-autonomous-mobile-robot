P_prior = @(Fx,Fu,P,Q) Fx * P * Fx' + Fu * Q * Fu';

%% SECTION FOR SELF-EVALUATION. PLEASE DO NOT EDIT BELOW THIS LINE %%%

Fx = [2 1;1 2]
Fu = [2 1;1 2]
P = [1 0;0 1]
Q = [.5 0;0 .5]

P_prior_eval = P_prior(Fx,Fu,P,Q)

