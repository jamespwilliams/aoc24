lines = File.read_lines("input")

locations = lines.map { |line|
  Tuple(Int32, Int32).from(line.split.map(&.to_i))
}

lefts = locations.map(&.first)
rights = locations.map(&.last)

right_counts = Hash(Int32, Int32).new(0)
rights.each { |id|
  right_counts[id] += 1
}

puts lefts.map { |id| right_counts[id] * id }.sum
