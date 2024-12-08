alias Grid = Array(Array(Char))
alias Position = Tuple(Int32, Int32)

grid = File.read_lines("input").map(&.chars)
height = grid.size
width = grid[0].size

antennae_positions = Hash(Char, Array(Position)).new { |h, k| h[k] = Array(Position).new }
grid.each_with_index do |row, y|
  row.each_with_index do |char, x|
    next if char == '.'
    antennae_positions[char].push({x, y})
  end
end

antinodes = Set(Position).new
antennae_positions.each do |frequency, positions|
  positions.combinations(2).each do |pair|
    a, b = pair
    ax, ay = a
    bx, by = b

    dx = bx - ax
    dy = by - ay

    antinode_1 = {ax - dx, ay - dy}
    antinode_2 = {bx + dx, by + dy}

    antinodes.add(antinode_1) if 0 <= antinode_1[0] < width && 0 <= antinode_1[1] < height
    antinodes.add(antinode_2) if 0 <= antinode_2[0] < width && 0 <= antinode_2[1] < height
  end
end

puts antinodes
puts antinodes.size
