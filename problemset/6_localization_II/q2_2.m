h = @(m, x_prior) m - x_prior;
Hx = @(m, x_prior) -eye(2);

%% SECTION FOR SELF-EVALUATION. PLEASE DO NOT EDIT BELOW THIS LINE %%%

x_prior = [1;2]
m = [3;3]

h_eval = h(m,x_prior)
Hx_eval = Hx(m,x_prior)
