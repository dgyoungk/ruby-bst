require_relative 'node.rb'

class Tree
  attr_accessor :root, :values
  @@arr_capacity = 5 + rand(15)

  def initialize()
    self.values = (1..9).to_a
    self.root = build_tree(values)
  end

  def self.arr_capacity
    @@arr_capacity
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

  def height(temp_root = self.root, value)
    return 0 if temp_root.nil?
    # the amount of jumps it takes to get to a leaf node from the
    # node with the given value
    # so let's say value is 8
    # once the node with value 8 is found
    # loop through its subtrees and increment 1 if one is present
    # for both left and right, return the greater of the 2
    if temp_root.data > value
      temp_root.node_height = height(temp_root.left, value)
      return temp_root.node_height
    elsif temp_root.data < value
      temp_root.node_height = height(temp_root.right, value)
      return temp_root.node_height
    end
    return 0 if temp_root.left.nil? && temp_root.right.nil?
    l_count = 0
    r_count = 0
    # case where the node containing the value has one nil subtree
    if temp_root.left.nil? || temp_root.right.nil?
      current = temp_root.left.nil? ? temp_root.right : temp_root.left
      if current.left.nil? && current.right.nil?
        temp_root.node_height = 1
        return temp_root.node_height
      end
      root_left = current.left
      root_right = current.right
      until root_left.nil? && root_right.nil?
        l_count += 1 unless root_left.nil?
        r_count += 1 unless root_right.nil?
        root_left = root_left.left
        root_right = root_right.right
      end
      temp_root.node_height = l_count >= r_count ? l_count : r_count
      return temp_root.node_height
    else
      # case where the node containing the value has both subtress (L/R)
      root_left = temp_root.left
      root_right = temp_root.right
      while !(root_left.nil? && root_right.nil?)
        l_count += 1 unless root_left.nil?
        r_count += 1 unless root_right.nil?
        root_left = root_left.left unless root_left.nil?
        root_right = root_right.right unless root_right.nil?
      end
      # until left_sub_left.nil? || left_sub_right.nil? && right_sub_left.nil? || right_sub_right.nil?
      #   l_count += 1 unless left_sub_left.nil? && right_sub_left.nil?
      #   r_count += 1 unless left_sub_right.nil? && right_sub_right.nil?
      #   left_sub_left = left_sub_left.left
      #   left_sub_right = left_sub_right.right
      #   right_sub_left = right_sub_left.left
      #   right_sub_right = right_sub_right.right
      # end
      temp_root.node_height = l_count >= r_count ? l_count : r_count
      return temp_root.node_height
    end

  end

  def depth(node)

  end

  def balanced?

  end

  def rebalance

  end

  # methods that accept a block
  def level_order
    yield
  end

  def preorder
    yield
  end

  def inorder
    yield
  end

  def postorder
    yield
  end
end
