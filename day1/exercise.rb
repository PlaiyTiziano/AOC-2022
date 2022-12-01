totals = [0]

File.foreach("./input.txt") { |line| line == "\n" ? totals.push(0) : totals[-1] += line.to_i }

puts "part 1 #{puts totals.max}"

totals = totals.sort

puts totals[-1] + totals[-2] + totals[-3]
