file = File.open('./input.txt')

# class Item
#   attr_accessor :top, :right, :bottom, :left, :value
#
#   def initialize(value, top, right, bottom, left)
#     @value = value
#     @top = top
#     @right = right
#     @bottom = bottom
#     @left = left
#   end
#
#   def visible?
#     value > top || value > right || value > bottom || value > left
#   end
# end

grid = file.readlines.reduce([]) do |g, line|
  g.push(line.chomp.split('').map(&:to_i))
end

def tree_is_visible?(grid, row, column)
  tree_value = grid[row][column]

  return false if tree_value.zero?

  left_max = grid[row][0..(column - 1)].max
  right_max = grid[row][(column + 1)..].max
  top_max = 0
  bottom_max = 0

  grid.each_with_index do |r, idx|
    top_max = r[column] if idx < row && top_max < r[column]
    bottom_max = r[column] if idx > row && bottom_max < r[column]
  end

  tree_value > left_max || tree_value > right_max || tree_value > top_max || tree_value > bottom_max
end

def visible_trees(grid)
  amount = grid.length * 2 + (grid[0].length - 2) * 2

  for row in 1..grid.length - 2 do
    for column in 1..grid[row].length - 2 do
      amount += 1 if tree_is_visible?(grid, row, column)
    end
  end

  amount
end

puts "Part 1: #{visible_trees(grid)}"

def sum_of_lt_values(arr, threshold)
  arr.reduce(0) do |sum, val|
    break sum + 1 if val >= threshold

    sum + 1
  end
end

def score_tree(grid, row, column)
  tree_value = grid[row][column]

  left_score = column.zero? ? 1 : sum_of_lt_values(grid[row][0..(column - 1)].reverse, tree_value)
  right_score = column == grid[row].length - 1 ? 1 : sum_of_lt_values(grid[row][(column + 1)..], tree_value)

  top, bot = grid.each_with_object([[], []]).with_index do |(val, acc), idx|
    acc[0].push(val[column]) if idx < row
    acc[1].push(val[column]) if idx > row
  end

  top_score = top.empty? ? 1 : sum_of_lt_values(top.reverse, tree_value)
  bottom_score = bot.empty? ? 1 : sum_of_lt_values(bot, tree_value)

  left_score * right_score * top_score * bottom_score
end

def best_scenic_tree(grid)
  scores = []

  for row in 0..grid.length - 1 do
    for column in 0..grid[row].length - 1 do
      scores.push(score_tree(grid, row, column))
    end
  end

  scores.max
end

# 574080
puts "Part 2: #{best_scenic_tree(grid)}"
