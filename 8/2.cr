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

    pair_dx = bx - ax
    pair_dy = by - ay

    gcd = pair_dx.gcd(pair_dy)
    antinode_dx = pair_dx // gcd
    antinode_dy = pair_dy // gcd

    # antinodes occur every (antinode_dx, antinode_dy) between the pair:
    x, y = ax, ay
    while 0 <= x < width && 0 <= y < height
      antinodes.add({x, y})
      x -= antinode_dx
      y -= antinode_dy
    end
    x, y = ax, ay
    while 0 <= x < width && 0 <= y < height
      antinodes.add({x, y})
      x += antinode_dx
      y += antinode_dy
    end
  end
end

antinodes.each do |x, y|
  grid[y][x] = '#'
end

puts grid.map { |row| row.join }.join("\n")

puts antinodes.size
