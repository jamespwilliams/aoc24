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

grid = File.read_lines("input").map(&.chars)

start_y = grid.index! do |row|
  row.includes?('^')
end
start_x = grid[start_y].index!('^')

dx, dy = UP
x, y = start_x, start_y
height = grid.size
width = grid[0].size

positions = Set({Int32, Int32}).new
loop do
  break unless 0 <= x < width
  break unless 0 <= y < height

  if grid[y][x] == '#'
    x -= dx
    y -= dy
    dx, dy = rotate_90(dx, dy)
    next
  end

  positions.add({x, y})
  x += dx
  y += dy
end
puts positions.size
