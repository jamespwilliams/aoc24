lines = File.read_lines("input")

locations = lines.map { |line|
  Tuple(Int32, Int32).from(line.split.map(&.to_i))
}

lefts = locations.map(&.first).sort
rights = locations.map(&.last).sort

diffs = lefts.zip(rights).map { |l, r| (l - r).abs }

puts diffs.sum
