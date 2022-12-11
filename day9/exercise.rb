# frozen_string_literal: true

require 'set'

file = File.open('./input.txt')

DIRECTIONS = {
  UP: 'U',
  RIGHT: 'R',
  DOWN: 'D',
  LEFT: 'L'
}.freeze

# Item
class Item
  attr_accessor :x, :y, :leader, :positions

  def initialize(leader = nil)
    @x = 0
    @y = 0
    @leader = leader
    @positions = Set.new([position_to_s])
  end

  def follow
    move_x = (leader.x - @x).abs > 1
    move_y = (leader.y - @y).abs > 1

    return false unless move_x || move_y

    if leader.x != @x && leader.y != @y
      move_diagonally
    else
      @x += @x < leader.x ? 1 : -1 if move_x
      @y += @y < leader.y ? 1 : -1 if move_y
    end

    store_position

    move_x || move_y
  end

  def move(direction = nil)
    case direction
    when DIRECTIONS[:UP]
      @y += 1
    when DIRECTIONS[:RIGHT]
      @x += 1
    when DIRECTIONS[:DOWN]
      @y -= 1
    when DIRECTIONS[:LEFT]
      @x -= 1
    end
  end

  def move_diagonally
    @x += @x < leader.x ? 1 : -1
    @y += @y < leader.y ? 1 : -1
  end

  def position_to_s
    # Wasted 2 hours on the key being stored in the hashmap as "#{x}#{y}" which
    # resutls in x: -1 y: 80 -> "-180" but x: -18, y: 0 is the same "-180" 😡😡😡
    "x: #{x}, y: #{y}"
  end

  def store_position
    @positions.add(position_to_s)
  end
end

head = Item.new
tail = Item.new(head)

file.readlines.each do |line|
  direction, steps = line.split(' ')

  steps.to_i.times do
    head.move(direction)
    tail.follow
  end
end

# 6486
puts "Part 1: #{tail.positions.size}"

file.rewind

knots = []
10.times { knots.push(Item.new(knots[-1])) }

file.readlines.each do |line|
  direction, steps = line.split(' ')

  steps.to_i.times do
    knots[0].move(direction)
    knots[1..].each do |knot|
      break unless knot.follow
    end
  end
end

# 2678
puts "Part 2: #{knots[-1].positions.size}"
