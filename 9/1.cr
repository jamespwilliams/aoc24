disk_map = File.read("input").strip.chars.map(&.to_i)

disk = [] of (Int32 | Nil)

iter = disk_map.each_with_index { |length, index|
  elem = index.even? ? index // 2 : nil
  disk += [elem] * length
}

left_cursor = 0
(0...disk.size).reverse_each do |right_cursor|
  next if disk[right_cursor] == '.'

  break if left_cursor >= right_cursor

  elem = disk[right_cursor]
  disk[right_cursor] = nil

  while disk[left_cursor] != nil
    left_cursor += 1
  end
  disk[left_cursor] = elem
end

puts disk.compact.map_with_index { |id, index|
  (id * index).to_i64
}.sum
