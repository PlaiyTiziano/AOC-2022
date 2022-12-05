file = File.open('./input.txt')

diagram, instructions = file.read.split("\n\n")

diagram_part1 = diagram.split("\n").each_with_object([]) do |line, d|
  next d unless line.include?('[')

  (1 + line.length / 4).times do |idx|
    char_idx = 1 + idx * 4
    d[idx] = [] unless d[idx]
    d[idx].prepend(line[char_idx]) unless line[char_idx] == "\s"
  end
end

instructions.split("\n").each do |line|
  amount, from, to = line.scan(/\d+/).map(&:to_i)
  diagram_part1[to - 1].push(*diagram_part1[from - 1].pop(amount).reverse)
end

# WCZTHTMPS
puts "Part 1: #{diagram_part1.map { |d| d[-1] }.join('')}"

diagram_part2 = diagram.split("\n").each_with_object([]) do |line, d|
  next d unless line.include?('[')

  (1 + line.length / 4).times do |idx|
    char_idx = 1 + idx * 4
    d[idx] = [] unless d[idx]
    d[idx].prepend(line[char_idx]) unless line[char_idx] == "\s"
  end
end

instructions.split("\n").each do |line|
  amount, from, to = line.scan(/\d+/).map(&:to_i)
  diagram_part2[to - 1].push(*diagram_part2[from - 1].pop(amount))
end

# BLSGJSDTS
puts "Part 1: #{diagram_part2.map { |d| d[-1] }.join('')}"
