class Node
  include Comparable
  attr_accessor :data, :left, :right, :node_height
  def <=>(other)
    self.data <=> other.data
  end

  def initialize(data, left = nil, right = nil)
    self.data = data
    self.left = left
    self.right = right
  end
end
