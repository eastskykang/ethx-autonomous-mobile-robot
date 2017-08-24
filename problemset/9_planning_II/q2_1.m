% the following elements are to be inserted into the heap
ElementsToInsert = [];
ElementsToInsert(1).pos = [3,1]; ElementsToInsert(1).key = 4;       
ElementsToInsert(2).pos = [3,2]; ElementsToInsert(2).key = 2;   
ElementsToInsert(3).pos = [3,3]; ElementsToInsert(3).key = 1; 
ElementsToInsert(4).pos = [4,2]; ElementsToInsert(4).key = 3;

% binary min-heap container
% use the same structure as for "ElementsToInsert"
BinMinHeap = [];

for n=1:1:length(ElementsToInsert)
    %insert ElementsToInsert(n) at the end of the heap
    new_node = ElementsToInsert(n);    
    new_idx = length(BinMinHeap) + 1;
    
    % add new heap to leaf
    BinMinHeap(new_idx).pos = new_node.pos;
    BinMinHeap(new_idx).key = new_node.key;
    
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
      