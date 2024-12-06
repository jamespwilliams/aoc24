alias Grid = Array(Array(Char))

UP    = {0, -1}
LEFT  = {1, 0}
DOWN  = {0, 1}
RIGHT = {-1, 0}

def rotate_90(dx : Int32, dy : Int32) : {Int32, Int32}
  case {dx, dy}
  when UP
    LEFT
  when LEFT
    DOWN
  when DOWN
    RIGHT
  else
    UP
  end
end

def does_loop(grid : Grid, start_x : Int32, start_y : Int32) : Bool
  height = grid.size
  width = grid[0].size

  dx, dy = UP
  x, y = start_x, start_y

  seen_positions_and_directions = Set({Int32, Int32, Int32, Int32}).new
  loop do
    break unless 0 <= x < width
    break unless 0 <= y < height

    if grid[y][x] == '#'
      x -= dx
      y -= dy
      dx, dy = rotate_90(dx, dy)
      next
    end

    if seen_positions_and_directions.includes?({x, y, dx, dy})
      return true
    end

    seen_positions_and_directions.add({x, y, dx, dy})
    x += dx
    y += dy
  end

  false
end

grid = File.read_lines("input").map(&.chars)

height = grid.size
width = grid[0].size

start_y = grid.index! do |row|
  row.includes?('^')
end
start_x = grid[start_y].index!('^')

puts (0...height).map do |y|
  (0...width).map do |x|
    next false if grid[y][x] != '.'

    puts x, y
    grid[y][x] = '#'
    loops = does_loop(grid, start_x, start_y)
    grid[y][x] = '.'
    loops
  end
end.flatten.count { |x| x }
