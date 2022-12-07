file = File.open('./input.txt')

THRESHOLD = 100_000

class Node
  attr_accessor :name, :size, :nodes, :parent

  def initialize(name:, size: 0, nodes: [], parent: nil)
    @name = name
    @size = size
    @nodes = nodes
    @parent = parent
  end

  def calculate_sizes
    return @size if @nodes.empty?

    @size = @nodes.reduce(0) do |size, node|
      next size += node.size if node.nodes.empty?

      size + node.calculate_sizes
    end

    @size
  end

  def sum_of_nodes_below_threshold_recursive
    return 0 if @nodes.empty?

    (@size <= THRESHOLD ? @size : 0) + @nodes.reduce(0) do |acc, node|
      acc + node.sum_of_nodes_below_threshold_recursive
    end
  end

  def sum_of_nodes_below_threshold
    return 0 if @nodes.empty?

    sum = @size <= THRESHOLD ? @size : 0
    nodes = [self]

    until nodes.empty?
      node = nodes.pop
      sum += node.size if node.size <= THRESHOLD && !node.nodes.empty?
      nodes.concat(node.nodes)
    end

    sum
  end
end

root = Node.new(name: '/')
curr_node = root

lines = file.read.split("\n")

# Build tree
for idx in 1..lines.length - 1 do
  if lines[idx].include?('$ ls')
    while lines[idx + 1] && !lines[idx + 1].include?('$')
      a, b = lines[idx + 1].split("\s")

      new_node = Node.new(name: b, parent: curr_node)
      curr_node.nodes.append(new_node)

      new_node.size = a.to_i unless a == 'dir'

      idx += 1
    end

    next
  elsif lines[idx].include?('$ cd')
    dir = lines[idx].split('$ cd ')[1]
    curr_node = dir == '..' ? curr_node.parent : curr_node.nodes.find { |node| node.name == dir }
    next
  end
end

root.calculate_sizes

# 1490523
puts "Part 1 (recursively): #{root.sum_of_nodes_below_threshold_recursive}"
puts "Part 1: #{root.sum_of_nodes_below_threshold}"

TOTAL_DISK_SPACE = 70_000_000
REQUIRED_UNUSED_SPACE = 30_000_000

TO_FREE_UP_SPACE = REQUIRED_UNUSED_SPACE - (TOTAL_DISK_SPACE - root.size)

$candidate_nodes = []

def nodes_gt(node)
  $candidate_nodes.push(node) if node.size >= TO_FREE_UP_SPACE

  node.nodes.each { |n| nodes_gt(n) }
end

nodes_gt(root)

# 12390492
puts "Part 2: #{$candidate_nodes.min_by(&:size).size}"
