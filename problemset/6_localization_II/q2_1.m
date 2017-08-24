f = @(x, u) x + u;
Fx = @(x,u) eye(2);
Fu = @(x,u) eye(2);

%%% SECTION FOR SELF-EVALUATION. PLEASE DO NOT EDIT BELOW THIS LINE %%%

x = [1;2]
u = [3;4]

f_eval = f(x,u)
Fx_eval = Fx(x,u)
Fu_eval = Fu(x,u)

