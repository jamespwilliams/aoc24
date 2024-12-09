alias Map = Array(Array(Int32))
alias Position = Tuple(Int32, Int32)

map = File.read_lines("input").map { |l| l.chars.map(&.to_i) }

def distinct_paths_to_summit(map : Map, x : Int32, y : Int32) : Int32
  level = map[y][x]

  if level == 9
    return 1
  end

  height = map.size
  width = map[0].size

  sum = 0
  sum += distinct_paths_to_summit(map, x + 1, y) if x + 1 < width && map[y][x + 1] == level + 1
  sum += distinct_paths_to_summit(map, x - 1, y) if x - 1 >= 0 && map[y][x - 1] == level + 1
  sum += distinct_paths_to_summit(map, x, y + 1) if y + 1 < height && map[y + 1][x] == level + 1
  sum += distinct_paths_to_summit(map, x, y - 1) if y - 1 >= 0 && map[y - 1][x] == level + 1

  sum
end

zero_positions = map.map_with_index { |row, y|
  row.map_with_index { |level, x| level == 0 ? {x, y} : nil }.compact
}.flatten

puts zero_positions.map { |x, y| distinct_paths_to_summit(map, x, y) }.sum
