require_relative 'tree.rb'


bst = Tree.new

puts %(Initial tree output of size 15: )
puts
bst.pretty_print



puts %(\nUpdated tree after inserting 24, 42, 22: )
bst.insert(24)
bst.insert(42)
bst.insert(22)
puts
bst.pretty_print

puts %(\nUpdated tree after deleting 24: )
bst.delete(24)
puts
bst.pretty_print

puts %(\nDisplaying the node with value 10:)
p bst.find(10)

puts %(\nThe height of a node with value 14:)
p bst.height(14)

puts %(\nThe depth of a node with value 22:)
p bst.depth(22)

puts %(\nChecking whether the tree is balanced..)
if bst.balanced?
  puts %(\nThe tree is balanced)
else
  puts %(\nThe tree is unbalanced. Rebalancing...)
  bst.rebalance
  puts %(\nThe tree after rebalancing:)
  bst.pretty_print
end

puts %(\nTree traversal:)

puts %(\nTraversing in level order with a block...)
bst.level_order { |node| p node.data }
puts %(\nTraversing in level order without a block...)
p bst.level_order

puts %(\nTraversing in preorder with a block...)
bst.preorder { |node| p node.data }
puts %(\nTraversing in preorder without a block...)
p bst.preorder

puts %(\nTraversing inorder with a block...)
bst.inorder { |node| p node.data }
puts %(\nTraversing inorder without a block...)
p bst.inorder

puts %(\nTraversing in postorder with a block...)
bst.postorder { |node| p node.data }
puts %(\nTraversing in postorder without a block...)
p bst.postorder
