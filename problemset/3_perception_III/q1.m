sigma = 1;
mean = 0;

% width filter = radius * 2 + 1
radius = 2;

f = normpdf(-radius:radius, mean, sigma);

% normalization
f = f./sum(f);