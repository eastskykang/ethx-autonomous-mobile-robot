% parameter
tol      =  0.01;
maxIter  = 50;

% initialize map
Map = zeros(11,9);
Map(1,:) = -1; Map(11,:) = -1; Map(:,1) = -1; Map(:,9)     = -1;
Map(9,2) = -1; Map(10,2) = -1; Map(10,3)= -1; Map(5:6,5:8) = -1;

% initialize search start and goal locations
SearchStart = [3,7];
SearchGoal  = [9,6];

% initialize iterative search
SearchSolution = zeros(size(Map));
SearchSolution(Map==-1)=1;   %set obstacle cells to "1"
SearchSolution(Map==0) =0.5; %set free cells to "0.5"
SearchSolution(SearchGoal(1),SearchGoal(2)) = 0;

% iteratively solve the discrete Laplace Equation with Dirichlet boundary conditions

% iteration counter
iter = 1;
prevSolution = inf(size(Map));

while iter < maxIter && max(abs(prevSolution(:) - SearchSolution(:))) > tol
    
    % solution of prev iteration 
    prevSolution = SearchSolution;
    
    % for (x, y) 
    x_bound = size(prevSolution, 1);
    y_bound = size(prevSolution, 2);
    
    % assume boundary of space is obstacles
    for x = 1:x_bound
        for y = 1:y_bound
           
            if prevSolution(x, y) == 1 || prevSolution(x, y) == 0
                % do not update goal or obstacles
                SearchSolution(x, y) = prevSolution(x, y);
                
                continue;
            end
            
            % update other cells (mean value of neighbors)
            U_q = prevSolution(x-1, y) + prevSolution(x+1, y) + ...
                prevSolution(x, y-1) + prevSolution(x, y+1);
            
            U_q = U_q / 4;
            
            SearchSolution(x, y) = U_q;
        end
    end
        
    % update iteration counter
    iter = iter + 1;
end

% visualize the solution
imagesc(SearchSolution)
set(gca,'dataAspectRatio',[1 1 1])