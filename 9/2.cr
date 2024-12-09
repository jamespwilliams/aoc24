disk_map = File.read("input").strip.chars.map(&.to_i)

disk = [] of Tuple(Int32 | Nil, Int32)

iter = disk_map.each_with_index { |length, index|
  elem = index.even? ? index // 2 : nil
  disk.push({elem, length})
}

(0...disk.size).reverse_each do |right_cursor|
  elem, len = disk[right_cursor]
  next if elem == nil

  free_slot = disk.each.index do |slot|
    candidate_elem, candidate_len = slot
    candidate_elem != nil && candidate_len >= len
  end

  next if free_slot.nil? || free_slot >= right_cursor

  _, free_len = disk[free_slot]
  disk[free_slot] = {elem, len}
  disk[right_cursor] = {nil, len}
  disk.insert(free_slot + 1, {nil, free_len - len})
end

sum, position = 0_i64, 0
disk.each do |elem_length|
  elem, length = elem_length

  length.times do
    sum += elem * position unless elem.nil?
    position += 1
  end
end

pp sum
