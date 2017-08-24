y = @(z, h) z - h;
S = @(Hx, P_prior, R) Hx * P_prior * Hx' + R;
K = @(Hx, P_prior, S) P_prior * Hx' / S;
x_posterior = @(x_prior, K, y) x_prior + K * y;
P_posterior = @(Hx, P_prior, K) P_prior - P_prior * Hx' * K';

%%% SECTION FOR SELF-EVALUATION. PLEASE DO NOT EDIT BELOW THIS LINE %%%

z = [1.1;1.9]
h = [1;2]
Hx = [2 1;1 2]
P_prior = [1 0;0 1]
R = [.5 0; 0 .5]
x_prior = [1;2]

y_eval = y(z,h)
S_eval = S(Hx, P_prior, R)
K_eval = K(Hx, P_prior, S_eval)
x_posterior_eval = x_posterior(x_prior, K_eval, y_eval)
P_posterior_eval = P_posterior(Hx, P_prior, K_eval)

