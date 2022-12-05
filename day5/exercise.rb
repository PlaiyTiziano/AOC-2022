file = File.open('./input.txt')

crates = []

file.readlines.each do |line|
  if line.include?('[')
    cursor = 1

    (line.length / 4).times do
      crate_idx = cursor / 4
      crates[crate_idx] = [] unless crates[crate_idx]
      crates[crate_idx].prepend(line[cursor]) unless line[cursor] == "\s"
      cursor += 4
    end
  elsif line.include?('move')
    amount, from, to = line.scan(/\d+/).map(&:to_i)

    crates[to - 1].push(*crates[from - 1].pop(amount).reverse)
  end
end

# WCZTHTMPS
top_layer = crates.map { |c| c[-1] }
puts "Part 1: #{top_layer.join('')}"

file.rewind

crates2 = []

file.readlines.each do |line|
  if line.include?('[')
    cursor = 1

    (line.length / 4).times do
      crate_idx = cursor / 4
      crates2[crate_idx] = [] unless crates2[crate_idx]
      crates2[crate_idx].prepend(line[cursor]) unless line[cursor] == "\s"
      cursor += 4
    end
  elsif line.include?('move')
    amount, from, to = line.scan(/\d+/).map(&:to_i)

    crates2[to - 1].push(*crates2[from - 1].pop(amount))
  end
end

# BLSGJSDTS
top_layer2 = crates2.map { |c| c[-1] }
puts "Part 2: #{top_layer2.join('')}"
