alias Map = Array(Array(Char))
alias Move = Char

def parse_input(lines : Array(String)) : Tuple(Map, Array(Move))
  i = lines.index!("")
  map, moves = lines[...i], lines[(i + 1)..]

  map = map.map { |row| row.gsub("#", "##").gsub("O", "[]").gsub(".", "..").gsub("@", "@.") }

  {map.map(&.chars), moves.join.chars}
end

def puts_map(map : Map)
  puts map.map(&.join).join("\n")
end

def map_score(map : Map) : Int32
  map.map_with_index { |row, y|
    row.map_with_index { |char, x|
      if char != '['
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

def swap(map : Map, x1 : Int32, y1 : Int32, x2 : Int32, y2 : Int32)
  tmp = map[y2][x2]
  raise "expected free square" unless tmp == '.'
  map[y2][x2] = map[y1][x1]
  map[y1][x1] = tmp
end

# try and move the object at {x, y} {dx, dy} squares, recursing if necessary
# return nil if the object was successfully moved, the moved map otherwise
def try_move(map : Map, x : Int32, y : Int32, dx : Int32, dy : Int32) : Map?
  map = map.clone

  # we can't move into a wall:
  if map[y + dy][x + dx] == '#'
    return nil
  end

  # moving into free space is simple:
  if map[y + dy][x + dx] == '.'
    swap(map, x, y, x + dx, y + dy)
    return map
  end

  horizontal_move = dy == 0
  if horizontal_move
    map = try_move(map, x + dx, y + dy, dx, dy)
    return nil if map.nil?

    swap(map, x, y, x + dx, y + dy)
    return map
  end

  # otherwise, we're doing a vertical move, which will involve pushing two box components
  # find the x co-ordinates of these components:
  box_xs = [x]
  if map[y + dy][x + dx] == '['
    box_xs.push(x + 1)
  else
    box_xs.push(x - 1)
  end

  # try and move both box components:
  map = try_move(map, box_xs[0], y + dy, dx, dy)
  return nil if map.nil?

  map = try_move(map, box_xs[1], y + dy, dx, dy)
  return nil if map.nil?

  swap(map, x, y, x + dx, y + dy)
  return map
end

def do_move(map : Map, move : Move) : Map
  robot_y = map.index! { |row| row.includes?('@') }
  robot_x = map[robot_y].index!('@')

  dx, dy = move_dx_dy(move)

  new_map = try_move(map, robot_x, robot_y, dx, dy)
  return new_map.nil? ? map : new_map
end

map, moves = parse_input(File.read_lines("input"))

moves.each do |move|
  map = do_move(map, move)
end

puts map_score(map)
