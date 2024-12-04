grid = File.read_lines("input").map(&.chars)

alias Grid = Array(Array(Char))

def xmas_starting_at(grid : Grid, x : Int32, y : Int32) : Int
  height = grid.size
  width = grid[0].size

  directions = [{1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}]

  directions.count do |dx, dy|
    next false unless 0 <= x + (3 * dx) < width
    next false unless 0 <= y + (3 * dy) < height

    grid[y][x] == 'X' && grid[y + dy][x + dx] == 'M' && grid[y + 2*dy][x + 2*dx] == 'A' && grid[y + 3*dy][x + 3*dx] == 'S'
  end
end

height = grid.size
width = grid[0].size

puts (0...height).map do |y|
  (0...width).map do |x|
    xmas_starting_at(grid, x, y)
  end
end.flatten.sum
