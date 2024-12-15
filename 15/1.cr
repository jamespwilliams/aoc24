alias Map = Array(Array(Char))
alias Move = Char

def parse_input(lines : Array(String)) : Tuple(Map, Array(Move))
  i = lines.index!("")
  map, moves = lines[...i], lines[(i + 1)..]

  {map.map(&.chars), moves.join.chars}
end

def puts_map(map : Map)
  puts map.map(&.join).join("\n")
end

def map_score(map : Map) : Int32
  map.map_with_index { |row, y|
    row.map_with_index { |char, x|
      if char != 'O'
        next 0
      end
      (100 * y) + x
    }.sum
  }.sum
end

def move_dx_dy(move : Move) : Tuple(Int32, Int32)
  case move
  when '^'
    {0, -1}
  when '>'
    {1, 0}
  when '<'
    {-1, 0}
  when 'v'
    {0, 1}
  else
    raise "unknown move " + move
  end
end

def do_move(map : Map, move : Move)
  robot_y = map.index! { |row| row.includes?('@') }
  robot_x = map[robot_y].index!('@')

  dx, dy = move_dx_dy(move)

  # try and find a sequence of 'O's, ending in a '.'. an empty sequence is also valid.
  x, y = robot_x + dx, robot_y + dy
  while map[y][x] != '#' && map[y][x] != '.'
    x += dx
    y += dy
  end

  if map[y][x] == '#'
    # we hit a wall before finding a free slot
    return
  end

  # we did find a sequence ending in a free slot: fill the sequence in with boxes
  x, y = robot_x, robot_y
  while map[y][x] != '.'
    map[y][x] = 'O'
    x += dx
    y += dy
  end
  map[y][x] = 'O'

  # move the robot
  map[robot_y][robot_x] = '.'
  map[robot_y + dy][robot_x + dx] = '@'
end

map, moves = parse_input(File.read_lines("input"))

moves.each do |move|
  do_move(map, move)
end

puts_map map
puts map_score(map)
