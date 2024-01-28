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

  def height(node)

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
