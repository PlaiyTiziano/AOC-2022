# frozen_string_literal: true

file = File.open('./input.txt')

total = file.readlines.reduce(0) do |sum, line|
  a, b = line.split(',')

  start_a, end_a = a.split('-').map(&:to_i)
  start_b, end_b = b.split('-').map(&:to_i)

  next sum + 1 if (start_a <= start_b && end_a >= end_b) || (start_b <= start_a && end_b >= end_a)

  sum
end

# Expected: 528
puts "Part 1: #{total}"

file.rewind

total2 = file.readlines.reduce(0) do |sum, line|
  a, b = line.split(',')

  range_a = Range.new(*a.split('-').map(&:to_i))
  range_b = Range.new(*b.split('-').map(&:to_i))

  next sum + 1 if range_a.cover?(range_b.min) || range_b.cover?(range_a.min)

  sum
end

# Expected : 881
puts "Part 2: #{total2}"
