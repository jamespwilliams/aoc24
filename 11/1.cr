def blink(stones : Array(Int64)) : Array(Int64)
  # perf: use a doubly-linked list instead
  result = [] of Int64

  stones.each do |stone|
    val = stone
    if val == 0
      result.push(1)
    elsif val.to_s.size % 2 == 0
      s = val.to_s
      right, left = s[0...s.size//2], s[s.size//2..]
      result.push(right.to_i64, left.to_i64)
    else
      result.push(val * 2024_i64)
    end
  end

  return result
end

# stones = [0_i64]
# stones = [0_i64]
stones = File.read("input").strip.split(" ").map(&.to_i64)

25.times do
  stones = blink(stones)
  # puts stones
end

puts stones.size
