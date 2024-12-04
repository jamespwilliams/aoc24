grid = File.read_lines("input").map(&.chars)

alias Grid = Array(Array(Char))

def mas_cross_at(grid : Grid, x : Int32, y : Int32) : Bool
  height = grid.size
  width = grid[0].size

  return false if x + 2 >= width || y + 2 >= height

  return false if grid[y + 1][x + 1] != 'A'

  top_left, top_right, bottom_left, bottom_right = grid[y][x], grid[y][x + 2], grid[y + 2][x], grid[y + 2][x + 2]

  return (
    (
      (top_left == 'M' && bottom_right == 'S') || (top_left == 'S' && bottom_right == 'M')
    ) && (
      (top_right == 'M' && bottom_left == 'S') || (top_right == 'S' && bottom_left == 'M')
    )
  )
end

height = grid.size
width = grid[0].size

puts (0...height).map do |y|
  (0...width).map do |x|
    mas_cross_at(grid, x, y)
  end
end.flatten.count { |x| x }
