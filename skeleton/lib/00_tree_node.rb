class PolyTreeNode
  attr_reader :value, :children, :parent

  def initialize(value, children = [])
    @value = value
    @children = children
    @parent = nil
  end

  def parent=(parent_node)
    parent.children.delete(self) if parent
    @parent = parent_node
    if parent_node
      parent_node.children.push(self) unless parent_node.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise ArgumentError unless child_node.parent
    child_node.parent = nil
  end

  def inspect
    "value = #{value} : children = #{children}"
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      child_path = child.dfs(target_value)
      return child_path if !child_path.nil?
    end

    nil
  end

  def bfs(target_value)
    q = MyQueue.new
    q.enqueue(self)

    until q.empty?
      current_node = q.dequeue
      return current_node if current_node.value == target_value
      current_node.children.each do |child|
        q.enqueue(child)
      end
    end
    nil
  end
end

class MyQueue
  attr_reader :store
  def initialize
    @store = []
  end

  def enqueue(el)
    store.push(el)
    self
  end

  def dequeue
    store.shift
  end

  def empty?
    store.empty?
  end
end
