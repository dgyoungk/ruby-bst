# TOP FS Ruby Project: Balanced Binary Search Tree

## Classes and Methods

### Node Class
    - blueprint for each item in the Tree
    - attributes: data, left, right

### Tree Class
    - blueprint for the search tree, takes an array of values upon instantiation
    - attributes: root

### Methods
    - #build_tree: builds the Tree of Node objects from the array of data;
        returns the root node
    - #insert(value): inserts the given value to the Tree
    - #delete(value): deletes the given value from the Tree
    - #find(value): returns the given node with the given value from the Tree; returns nil if not found
    - #height(Node): returns the number of edges from a given Node to the leaf Node 
    - #depth(Node): returns the number of edges from a given Node to the root Node
    - #balanced?: returns a boolean value indicating whether the height of the subtrees for each node is
        not more than 1
    - #rebalance: rebalances the Tree if #balanced? returns false
    Methods that accept a block
    returns an array is no block is given
    - #level_order: traverses the Tree in breadth-first order
    - #preorder: traverses the Tree in depth-first order of Data, Left, then Right
    - #inorder: traverses the Tree in depth-first order of Left, Data then Right
    - #postorder: traverses the Tree in depth-first order of Left, Right then Data
    

Author: Daniel Kwon 2024

**_method #pretty_print is cited from TOP's BST Project page_**