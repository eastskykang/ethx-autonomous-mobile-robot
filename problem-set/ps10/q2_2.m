% binary min-heap container
% let us assume the heap contains the following elements already and 
% is in a consistent state
BinMinHeap = [];
BinMinHeap(1).pos = [3,3]; BinMinHeap(1).key = 1;
BinMinHeap(2).pos = [4,2]; BinMinHeap(2).key = 3;
BinMinHeap(3).pos = [3,2]; BinMinHeap(3).key = 2;
BinMinHeap(4).pos = [3,1]; BinMinHeap(4).key = 4;
BinMinHeap(5).pos = [4,3]; BinMinHeap(5).key = 5;

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


      