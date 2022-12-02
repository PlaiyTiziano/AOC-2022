# frozen_string_literal: true

calories = File.open('./input.txt')
               .readlines
               .each_with_object([0]) do |line, totals|
                 line == "\n" ? totals.push(0) : totals[-1] += line.to_i
               end
               .sort

puts "part 1 #{calories[-1]}"
puts "part 2 #{calories.last(3).sum}"
