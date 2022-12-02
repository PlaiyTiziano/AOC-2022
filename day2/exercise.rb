file = File.open('./input.txt')

# X: Rock, Y: Paper, Z: scissors
HAND_SCORES = {
  X: 1,
  Y: 2,
  Z: 3
}.freeze

WIN = ['A Y', 'B Z', 'C X'].freeze
DRAW = ['A X', 'B Y', 'C Z'].freeze
LOSE = ['A Z', 'B X', 'C Y'].freeze

# Challenge 1
points = file.readlines.reduce(0) do |total, line|
  line = line.strip

  total += HAND_SCORES[line[-1].to_sym]

  next total + 3 if DRAW.include?(line)
  next total + 6 if WIN.include?(line)

  total
end

puts "Part 1: #{points}"

file.rewind

# Challenge 2
points_part2 = file.readlines.reduce(0) do |total, line|
  line = line.strip

  total + case line[-1]
          when 'Y'
            3 + HAND_SCORES[DRAW.find { |c| c[0] == line[0] }[-1].to_sym]
          when 'Z'

            6 + HAND_SCORES[WIN.find { |c| c[0] == line[0] }[-1].to_sym]
          else
            HAND_SCORES[LOSE.find { |c| c[0] == line[0] }[-1].to_sym]
          end
end

puts "Part 2: #{points_part2}"
