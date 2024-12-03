memory = File.read_lines("input").join

puts memory.scan(/mul\((\d+),(\d+)\)/).map { |match|
  match[1].to_i * match[2].to_i
}.sum
