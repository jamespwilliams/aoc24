def blink(stones : Hash(Int64, Int64)) : Hash(Int64, Int64)
  result = Hash(Int64, Int64).new { |h, k| h[k] = 0; 0_i64 }

  stones.each do |stone, freq|
    if stone == 0
      result[1_i64] += freq
    elsif stone.to_s.size % 2 == 0
      s = stone.to_s
      right, left = s[0...s.size//2], s[s.size//2..]
      result[right.to_i64] += freq
      result[left.to_i64] += freq
    else
      result[stone * 2024_i64] += freq
    end
  end

  return result
end

stones = File.read("input").strip.split(" ").map { |s| {s.to_i64, 1_i64} }.to_h

75.times do
  stones = blink(stones)
end

puts stones.values.sum
