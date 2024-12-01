lines = File.read_lines("input")

locations = lines.map { |line|
  ids = line.split(" ")
  {ids[0].to_i, ids[-1].to_i}
}

lefts = locations.map { |l| l[0] }.sort
rights = locations.map { |l| l[1] }.sort

diffs = lefts.zip(rights).map { |left, right| (left - right).abs }

puts diffs.sum
