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

def count_sides(boundaries : Set(Fence)) : Int32
  seen = Set(Fence).new

  # (sorting is important, so we iterate over boundaries in (x, y) order, to avoid
  # gaps in our iteration inflating the side count).
  boundaries.to_a.sort.count do |boundary|
    a, b = boundary
    ax, ay = a
    bx, by = b

    seen.add({a, b})

    # have we seen an adjoining section to this fence already?
    if ax == bx
      # vertical boundary: try and find a conjoining vertical fence:
      if !seen.includes?({ {ax + 1, ay}, {bx + 1, by} }) && !seen.includes?({ {ax - 1, ay}, {bx - 1, by} })
        next true
      end
    else
      # horizontal boundary: try and find a conjoining horizontal fence:
      if !seen.includes?({ {ax, ay + 1}, {bx, by + 1} }) && !seen.includes?({ {ax, ay - 1}, {bx, by - 1} })
        next true
      end
    end
  end
end

map = File.read_lines("input").map(&.chars)

seen = Set(Point).new

price = map.map_with_index do |row, y|
  row.map_with_index do |char, x|
    next 0 if seen.includes?({x, y})

    res = flood_fill_region(map, x, y, Set(Point).new)
    seen += res.points

    res.points.size * count_sides(res.boundaries)
  end.sum
end.sum

puts price
