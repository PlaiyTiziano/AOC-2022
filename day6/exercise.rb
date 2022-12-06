file = File.open('./input.txt')
input_string = file.read

idx = 3
unique_string = false

while idx < input_string.length
  chars = input_string[(idx - 3)..idx]

  until chars.empty?
    char = chars[-1]
    chars = chars[0..-2]
    break if chars.include?(char)

    unique_string = true if chars.length == 1
  end

  idx += 1
  break if unique_string
end

puts "Part 1: #{idx}"

file.rewind

idx = 13
unique_string = false

while idx < input_string.length
  chars = input_string[(idx - 13)..idx]

  until chars.empty?
    char = chars[-1]
    chars = chars[0..-2]
    break if chars.include?(char)

    unique_string = true if chars.length == 1
  end

  idx += 1
  break if unique_string
end

puts "Part 2: #{idx}"
