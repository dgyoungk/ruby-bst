class Node
  include Comparable
  attr_accessor :data, :left, :right
  def <=>(other)
    self.data <=> other.data
  end

  def initialize(data, left = nil, right = nil)
    self.data = data
    self.left = left
    self.right = right
  end
end
