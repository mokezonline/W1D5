require_relative "skeleton/lib/00_tree_node.rb"

class KnightPathFinder
  def initialize(initial_pos)
    @root_node = PolyTreeNode.new(initial_pos)
  end

end
