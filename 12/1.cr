alias Point = Tuple(Int32, Int32)

alias Fence = Tuple(Point, Point)

record FloodFillResult, points : Set(Point), boundaries : Set(Fence)

def flood_fill_region(map : Array(Array(Char)), x : Int32, y : Int32, seen : Set(Point)) : FloodFillResult
  width, height = map[0].size, map.size

  neighbours = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]

  boundaries = Set(Fence).new

  seen.add({x, y})

  neighbours.each do |nx, ny|
    next if seen.includes?({nx, ny})

    if nx >= width || nx < 0 || ny >= height || ny < 0
      # add boundary for the outside of the map:
      boundaries.add({ {x, y}, {nx, ny} })
      next
    end

    if map[y][x] != map[ny][nx]
      boundaries.add({ {x, y}, {nx, ny} })
      next
    end

    neighbour_result = flood_fill_region(map, nx, ny, seen)
    seen += neighbour_result.points
    boundaries += neighbour_result.boundaries
  end

  FloodFillResult.new(seen, boundaries)
end

map = File.read_lines("input").map(&.chars)

seen = Set(Point).new

price = map.map_with_index do |row, y|
  row.map_with_index do |char, x|
    next 0 if seen.includes?({x, y})

    res = flood_fill_region(map, x, y, Set(Point).new)
    seen += res.points

    res.points.size * res.boundaries.size
  end.sum
end.sum

puts price
