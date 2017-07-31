clear;
close all;
clc;

% initialize map, search start and goal as well as the solution map
Map = zeros(11,9);
Map(1,:) = -1; Map(11,:) = -1; Map(:,1) = -1; Map(:,9)     = -1;
Map(9,2) = -1; Map(10,2) = -1; Map(10,3)= -1; Map(5:6,5:8) = -1;

SearchStart = [3,7];
SearchGoal  = [9,6];

SolutionMap = Inf*ones(size(Map)); %store g-values in here during search


% A* search
% insert search start onto heap, using the Euclidean distance as heuristic
BinMinHeap(1).pos = SearchStart;
BinMinHeap(1).g   = 0;
BinMinHeap(1).h   = norm(SearchGoal-SearchStart);
BinMinHeap(1).key = BinMinHeap(1).g + BinMinHeap(1).h;

% iteratively expand states
goalReached = false;
while ~isempty(BinMinHeap) && ~goalReached
    % extract top element from heap (reuse your code from before) and
    % make it consistent again
    [CurrState, BinMinHeap] = HeapPop(BinMinHeap);
    
    % store the g value (cost so far) of the state in the solution map,
    % but only if this position has not been expanded before already!
    if ~isinf(SolutionMap(CurrState.pos(1), CurrState.pos(2)))
        % if it's not inf (init value), it already traveled
        continue;
    end
    
    SolutionMap(CurrState.pos(1),CurrState.pos(2)) = CurrState.key;
    
    % terminate search in case currState is the goal
    if CurrState.pos == SearchGoal
        goalReached = true;
        continue;
    end
    
    % expand neighbors of currState using the 8-neighborhood
    % i.e., straigt and diagonal neighbors. Traversal to diagonal
    % neighbors incurs a cost of sqrt(2). Insert them into the heap
    % if the corresponding cell is not occupied and ensure that the
    % heap becomes consistent again
    x_range = max(CurrState.pos(1) - 1, 1):min(CurrState.pos(1)+1, size(Map, 1));
    y_range = max(CurrState.pos(2) - 1, 1):min(CurrState.pos(2)+1, size(Map, 2));
    
    for x = x_range
        for y = y_range
            
            if Map(x, y) == -1 
                continue;
            end
            
            new.pos = [x, y];
            new.g   = CurrState.g + norm([x, y]-CurrState.pos);
            new.h   = norm(SearchGoal-[x, y]);
            new.key = new.g + new.h;

            BinMinHeap = HeapPush(new, BinMinHeap);
        end
    end
    
end

% visualize the solution map (g values)
imagesc(SolutionMap)
set(gca,'dataAspectRatio',[1 1 1])

function [BinMinHeap] = HeapPush(new, BinMinHeap)
    
    %insert ElementsToInsert(n) at the end of the heap
    new_node = new;
    new_idx = length(BinMinHeap) + 1;
    
    % add new heap to leaf
    BinMinHeap(new_idx).pos = new_node.pos;
    BinMinHeap(new_idx).key = new_node.key;
    BinMinHeap(new_idx).g = new_node.g;
    BinMinHeap(new_idx).h = new_node.h;
    
    %make heap consistent by moving the inserted element
    %up the binary tree
    while new_idx > 1 && BinMinHeap(new_idx).key < BinMinHeap(floor(new_idx/2)).key
        
        % swap
        % parent to child
        BinMinHeap(new_idx) = BinMinHeap(floor(new_idx/2));
        % child to parent
        BinMinHeap(floor(new_idx/2)) = new_node;
        
        % update idx
        new_idx = floor(new_idx/2);
    end
end

function [ExtractedElement, BinMinHeap] = HeapPop(BinMinHeap)
    % extract the minimal element from the heap and store it in "ExtractedElement"
    ExtractedElement = BinMinHeap(1);
    
    %make heap consistent again by first moving the bottom element
    %to the top and then down the binary tree
    BinMinHeap(1) = BinMinHeap(end);
    HeapSize = length(BinMinHeap);
    
    idx = 1;
    consistent = false;
    while ~consistent
        if HeapSize >= idx * 2 + 1 && ...   % two children
                BinMinHeap(idx).key > min(BinMinHeap(idx * 2).key, BinMinHeap(idx * 2 + 1).key) % and parent is larger
            
            % swap with min child
            temp = BinMinHeap(idx);
            
            if BinMinHeap(idx * 2).key > BinMinHeap(idx * 2 + 1).key
                % right child is min child
                BinMinHeap(idx) = BinMinHeap(idx * 2 + 1);
                BinMinHeap(idx * 2 + 1) = temp;
                
                idx = idx * 2 + 1;
            else
                % left child is min child
                BinMinHeap(idx) = BinMinHeap(idx * 2);
                BinMinHeap(idx * 2) = temp;
                
                idx = idx * 2;
            end
            
        elseif HeapSize == idx * 2 ... % one child
                BinMinHeap(idx).key > BinMinHeap(idx * 2).key % and parent is larger
            
            % swap with child
            temp = BinMinHeap(idx);
            
            BinMinHeap(idx) = BinMinHeap(idx * 2);
            BinMinHeap(idx * 2) = temp;
            
            idx = idx * 2;
        else
            consistent = true;
        end
    end
end
