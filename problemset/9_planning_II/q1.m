% write down the map (-1 for occupied and 0 for free cells)
Map         = [...
    -1  -1  -1  -1  -1  -1  -1  -1  -1;
    -1  0   0   0   0   0   0   0   -1;
    -1  0   0   0   0   0   0   0   -1;
    -1  0   0   0   0   0   0   0   -1;
    -1  0   0   0   -1  -1  -1  -1  -1;
    -1  0   0   0   -1  -1  -1  -1  -1;
    -1  0   0   0   0   0   0   0   -1;
    -1  0   0   0   0   0   0   0   -1;
    -1  -1  0   0   0   0   0   0   -1;
    -1  -1  -1  0   0   0   0   0   -1;
    -1  -1  -1  -1  -1  -1  -1  -1  -1];

% enter start and goal locations
SearchStart = [3, 7];
SearchGoal  = [9, 6];
        
% visualize the map
imagesc(Map)
set(gca,'dataAspectRatio',[1 1 1])
      