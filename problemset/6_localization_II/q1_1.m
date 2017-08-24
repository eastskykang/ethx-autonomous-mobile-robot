pTransition = [ 
    0   0   0   0   0
    0  .05  .1 .05  0
    0   .1  .4  .1  0
    0  .05  .1 .05  0
    0   0   0   0   0  ];
getPLocalTransition = @(localCoordinate) ...
    pTransition(localCoordinate(1) + 3, localCoordinate(2) + 3);
%%%%%%%%%%% PLEASE DON'T CHANGE ANYTHING ABOVE THIS LINE %%%%%%%%%%%

calcPTransition = @(x_t, u_t, x_tm1) ...
    getPLocalTransition(max([-2, -2], min([2, 2], xt - (x_tm1 + u_t)))); % maybe use getPLocalTransition
