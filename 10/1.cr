alias Map = Array(Array(Int32))
alias Position = Tuple(Int32, Int32)

map = File.read_lines("input").map { |l| l.chars.map(&.to_i) }

def summits_accessible_from(map : Map, x : Int32, y : Int32) : Set(Position)
  level = map[y][x]

  if level == 9
    return Set(Position).new.add({x, y})
  end

  height = map.size
  width = map[0].size

  sum = Set(Position).new
  sum += summits_accessible_from(map, x + 1, y) if x + 1 < width && map[y][x + 1] == level + 1
  sum += summits_accessible_from(map, x - 1, y) if x - 1 >= 0 && map[y][x - 1] == level + 1
  sum += summits_accessible_from(map, x, y + 1) if y + 1 < height && map[y + 1][x] == level + 1
  sum += summits_accessible_from(map, x, y - 1) if y - 1 >= 0 && map[y - 1][x] == level + 1

  sum
end

zero_positions = map.map_with_index { |row, y|
  row.map_with_index { |level, x| level == 0 ? {x, y} : nil }.compact
}.flatten

puts zero_positions.map { |x, y| summits_accessible_from(map, x, y).size }.sum
