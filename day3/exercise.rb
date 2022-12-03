# frozen_string_literal: true

RANKING = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

file = File.open('./input.txt')

total = file.readlines.reduce(0) do |sum, line|
  a, b = line.partition(/.{#{line.length / 2}}/)[1, 2]

  item_type = a.split('').find { |c| b.include?(c) }

  sum + (RANKING.index(item_type) + 1)
end

puts "Part 1: #{total}"

file.rewind

elf_groups = file.readlines.each_with_object([[]]) do |line, groups|
  groups.push([]) if groups[-1].length == 3

  groups[-1].push(line)
end

total2 = elf_groups.reduce(0) do |sum, group|
  a, b, c = group

  item_type = a.split('').find { |char| b.include?(char) && c.include?(char) }

  sum + (RANKING.index(item_type) + 1)
end

puts "Part 2: #{total2}"
