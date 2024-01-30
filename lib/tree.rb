require_relative 'node.rb'

class Tree
  attr_accessor :root, :values
  attr_reader :arr_capacity


  def initialize()
    @arr_capacity = 5 + rand(15)
    self.values = (1..15).to_a
    self.root = build_tree(values)
  end

  # sort and remove any duplicates before building the tree
  def build_tree(arr)
    return if arr.empty?
    arr = arr.sort.uniq
    middle = arr.length / 2
    tree_root = Node.new(arr[middle])
    tree_root.left = build_tree(arr[0...middle])
    tree_root.right = build_tree(arr[middle + 1..])
    return tree_root
  end

  # cited from TOP's BST Project page
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(temp_root = self.root, value)
    return Node.new(value) if temp_root.nil?
    if temp_root.data == value
      return temp_root
    elsif temp_root.data > value
      temp_root.left = insert(temp_root.left, value)
    elsif temp_root.data < value
      temp_root.right = insert(temp_root.right, value)
    end
    self.root = temp_root
  end

  def delete(temp_root = self.root, value)
    return temp_root if temp_root.nil?
    if temp_root.data > value
      temp_root.left = delete(temp_root.left, value)
      return temp_root
    elsif temp_root.data < value
      temp_root.right = delete(temp_root.right, value)
      return temp_root
    end
    if temp_root.left.nil?
      new_root = temp_root.right
      temp_root = nil
      return new_root
    elsif temp_root.right.nil?
      new_root = temp_root.left
      temp_root = nil
      return new_root
    else
      subsq_parent = temp_root
      subsq = temp_root.right
      until subsq.left.nil?
        subsq_parent = subsq
        subsq = subsq.left
      end
      subsq_parent != temp_root ? subsq_parent.left = subsq.right : subsq_parent.right = subsq.right
      temp_root.data = subsq.data
      subsq = nil
      return temp_root
    end
  end

  def find(temp_root = self.root, value)
    return temp_root if temp_root.nil?
    # return temp_root if temp_root.data == value
    if temp_root.data > value
      temp_root.left = find(temp_root.left, value)
    elsif temp_root.data < value
      temp_root.right = find(temp_root.right, value)
    else
      new_root = temp_root
      return new_root
    end
  end

  def height(value, temp_root = self.find(value))
    return -1 if temp_root.nil?
    left_h = height(value, temp_root.left)
    right_h = height(value, temp_root.right)
    if left_h > right_h
      height =  left_h + 1
      return left_h + 1
    else
      height = right_h + 1
      return right_h + 1
    end
  end

  def depth(temp_root = self.root, value)
    # the distance from the root to the node with the given value
    return -1 if temp_root.nil?
    distance = -1
    return distance + 1 if temp_root.data == value
    distance = depth(temp_root.left, value)
    return distance + 1 if distance >= 0
    distance = depth(temp_root.right, value)
    return distance + 1 if distance >= 0
    return distance
  end

  def balanced?
    # checks whether the height difference between the 2 subtrees is more than 1
    left_height = self.height(self.root.left.data)
    right_height = self.height(self.root.right.data)
    if left_height > right_height
      return left_height - right_height <= 1
    else
      return right_height - left_height <= 1
    end
  end

  def rebalance
    self.root = build_tree(self.level_order)
  end

  # methods that accept a block
  # if no block is provided, an array of values should be returned
  def level_order(temp_root = self.root, node_values = [], queue = [])
    # breadth-first: I need a queue
    # loop starting at root node, process then enqueue left then right
    unless block_given?
      queue.push(temp_root)
      while !queue.empty?
        current = queue.shift
        node_values << current.data
        queue.push(current.left) unless current.left.nil?
        queue.push(current.right) unless current.right.nil?
      end
      return node_values
    end
    queue.push(temp_root)
    while !queue.empty?
      current = queue.shift
      yield(current)
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end
    return %(traversal finished)
  end
# TODO: implement the depth-first traversal methods
  def preorder(current = self.root, node_values = [], &block)
    # preorder follows the DLR route (Data, Left then Right)
    unless block_given?
      return if current.nil?
      node_values << current.data
      preorder(current.left, node_values)
      preorder(current.right, node_values)
      return node_values
    end
    return %(traversal finished) if current.nil?
    yield(current)
    preorder(current.left, &block)
    preorder(current.right, &block)
  end

  def inorder(temp_root = self.root, node_values = [], &block)
    # inorder follows the LDR route
    unless block_given?
      return if temp_root.nil?
      inorder(temp_root.left, node_values)
      node_values << temp_root.data
      inorder(temp_root.right, node_values)
      return node_values
    end
    return %(traversal finished) if temp_root.nil?
    inorder(temp_root.left, &block)
    yield(temp_root)
    inorder(temp_root.right, &block)
  end

  def postorder(temp_root = self.root, node_values = [], &block)
    # postorder follows the LRD route
    unless block_given?
      return if temp_root.nil?
      postorder(temp_root.left, node_values)
      postorder(temp_root.right, node_values)
      node_values << temp_root.data
      return node_values
    end
    return %(traversal finished) if temp_root.nil?
    postorder(temp_root.left, &block)
    postorder(temp_root.right, &block)
    yield(temp_root)
  end
end
