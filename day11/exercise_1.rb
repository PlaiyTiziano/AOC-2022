file = File.open('./input.txt')

# class Monkey
class Monkey
  attr_accessor :items, :operation, :test, :monkey_true, :monkey_false, :inspection_counter, :original_items

  def initialize
    @inspection_counter = 0
  end

  def inspect(common_multiple)
    @inspection_counter += 1

    item = items.shift

    @worry_level = item.send(@operation[0], @operation[1] == 'old' ? item : @operation[1].to_i) % common_multiple
  end

  def test?
    (@worry_level % test).zero?
  end

  def throw
    return monkey_true.items.push(@worry_level) if test?

    monkey_false.items.push(@worry_level)
  end

  def reset
    @inspection_counter = 0
    @items = @original_items
  end
end

# class Game
class Game
  attr_accessor :monkeys

  def initialize(monkeys)
    @monkeys = monkeys
  end

  def common_multiple
    @common_multiple ||= @monkeys.reduce(1) { |acc, m| acc * m.test } * 3
  end

  def round
    monkeys.each do |monkey|
      until monkey.items.empty?
        monkey.inspect(common_multiple)
        monkey.throw
      end
    end
  end

  def play(rounds, common_multiple = nil)
    @common_multiple = common_multiple
    rounds.times { round }
  end

  def monkeys_sorted_by_inspection_counter
    @monkeys.sort_by(&:inspection_counter)
  end

  def reset
    @monkeys.each(&:reset)
    @common_multiple = nil
  end
end

monkeys_info = file.read.split("\n\n")
monkeys = Array.new(monkeys_info.length) { Monkey.new }

monkeys.each_with_index do |monkey, idx|
  info = monkeys_info[idx].split("\n")

  monkey.items = info[1].scan(/\d+/).map(&:to_i)
  monkey.original_items = info[1].scan(/\d+/).map(&:to_i)
  monkey.operation = info[2].split('Operation: new = old ')[1].split("\s")
  monkey.test = info[3].scan(/\d+/)[0].to_i
  monkey.monkey_true = monkeys[info[4].scan(/\d+/)[0].to_i]
  monkey.monkey_false = monkeys[info[5].scan(/\d+/)[0].to_i]
end

game = Game.new(monkeys)

def part1(game)
  game.play(20, 3)
  first, second = game.monkeys_sorted_by_inspection_counter[-2..]
  first.inspection_counter * second.inspection_counter
end

# 117624
puts "Part 1: #{part1(game)}"

game.reset

def part2(game)
  game.play(10_000)
  first, second = game.monkeys_sorted_by_inspection_counter[-2..]
  first.inspection_counter * second.inspection_counter
end

# 16792940265
puts "Part 2: #{part2(game)}"
