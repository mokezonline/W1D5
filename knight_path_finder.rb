require_relative "skeleton/lib/00_tree_node.rb"

class KnightPathFinder
  BOARD_LENGTH = 8

  def self.valid_moves(pos)
    row = pos.first
    col = pos.last
    moves = []
    [-2, -1, 1, 2].each do |i|
      [-2, -1, 1, 2].each do |j|
        next if (i + j).even?
        new_pos = [row + i, col + j]
        if new_pos.min >= 0 && new_pos.max < BOARD_LENGTH
          moves << new_pos
        end
      end
    end

    moves
  end

  def initialize(initial_pos)
    @root_node = PolyTreeNode.new(initial_pos)
    @visited_positions = [initial_pos]
  end

  def new_move_positions(pos)
    moves = self.class.valid_moves(pos)
    moves.reject! { |move| @visited_positions.include?(move) }
    @visited_positions += moves
    moves
  end

  def build_move_tree
    q = MyQueue.new
    q.enqueue(@root_node)
    until q.empty?
      current_node = q.dequeue
      new_moves = new_move_positions(current_node.value)
      new_moves.each do |move|
        node = PolyTreeNode.new(move)
        node.parent = current_node
        q.enqueue(node)
      end
    end

    @root_node
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    trace_path_back(end_node) if end_node
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    current_node = end_node
    until current_node == @root_node
      current_node = current_node.parent
      path.unshift(current_node.value)
    end

    path
  end
end
