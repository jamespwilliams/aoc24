lines = File.read_lines("input")

locations = lines.map { |line|
  ids = line.split(" ")
  {ids[0].to_i, ids[-1].to_i}
}

lefts = locations.map { |l| l[0] }.sort
rights = locations.map { |l| l[1] }.sort

right_counts = rights.reduce({} of Int32 => Int32) { |counts, id|
  counts[id] = 0 unless counts.has_key?(id)
  counts[id] += 1
  counts
}

puts lefts.map { |id| (right_counts.fetch(id, 0) * id) }.sum
