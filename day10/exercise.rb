# frozen_string_literal: true

instructions = File.open('./input.txt').read.split("\n")
# instructions = File.open('./sample_input.txt').read.split("\n")

def sum_of_signal_strength(instructions)
  cycles = 0
  register_x = 1
  score_memo = []
  scoring_intervals = [20, 60, 100, 140, 180, 220]

  instructions.each do |instruction|
    a, b = instruction.split("\s")

    save_score = lambda do
      score_memo.push(register_x * cycles) if scoring_intervals.include?(cycles)
    end

    if a == 'noop'
      cycles += 1
      save_score.call
    else
      2.times do
        cycles += 1
        save_score.call
      end
      register_x += b.to_i
    end
  end

  score_memo.sum
end

# 13220
puts "Part 1: #{sum_of_signal_strength(instructions)}"

def screen_output(instructions)
  screen = Array.new(6) { Array.new(40).fill('.') }

  crt_pos_x = 0
  crt_pos_y = 0
  register_pos_x = 1

  draw = lambda do
    screen[crt_pos_y][crt_pos_x] = ((register_pos_x - 1)..(register_pos_x + 1)).cover?(crt_pos_x) ? '#' : '.'

    if crt_pos_x == 39
      crt_pos_y += 1
      crt_pos_x = 0
    else
      crt_pos_x += 1
    end
  end

  instructions.each do |instruction|
    a, b = instruction.split("\s")

    draw.call
    draw.call if a == 'addx'
    register_pos_x += b.to_i if b
  end

  screen
end

# RUAKHBEK
puts "Part 2:\n#{screen_output(instructions).map(&:join).join("\n")}"
