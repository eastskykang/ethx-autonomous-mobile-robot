% all previously implemented anonymous functions go here
%motion model and Jacobians
f = @(x, u) x + u;
Fx = @(x,u) eye(2);
Fu = @(x,u) eye(2);
%measurement model and Jacobian
h = @(m, x_prior) m - x_prior;
Hx = @(m, x_prior) -eye(2);
%covariance propagation
P_prior = @(Fx,Fu,P,Q) Fx * P * Fx' + Fu * Q * Fu';
%estimate update
y = @(z, h) z - h;
S = @(Hx, P_prior, R) Hx * P_prior * Hx' + R;
K = @(Hx, P_prior, S) P_prior * Hx' / S;
x_posterior = @(x_prior, K, y) x_prior + K * y;
P_posterior = @(Hx, P_prior, K) P_prior - P_prior * Hx' * K';