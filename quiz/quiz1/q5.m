syms F(x, y) G(x, y)

% write down the formula to compare two image patches via SSD 
e = sum((F(x,y) - G(x,y)).^2);
      