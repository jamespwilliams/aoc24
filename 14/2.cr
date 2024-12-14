record Robot, px : Int32, py : Int32, vx : Int32, vy : Int32

robots = [] of Robot
File.read_lines("input").each do |line|
  px, py, vx, vy = line.scan(/-?\d+/).map { |match| match[0].to_i }

  robots.push(Robot.new(px, py, vx, vy))
end

def positions_after_n_iterations(robots : Array(Robot), n : Int32) : Hash(Tuple(Int32, Int32), Int32)
  square_counts = Hash(Tuple(Int32, Int32), Int32).new { |h, k| h[k] = 0; h[k] }

  w, h = 101, 103

  robots.each do |robot|
    final_x = ((robot.px % w) + (((robot.vx % w) * (n % w)) % w)) % w
    final_y = ((robot.py % h) + (((robot.vy % h) * (n % h)) % h)) % h

    square_counts[{final_x, final_y}] += 1
  end
  square_counts
end

(0..10000).each do |iterations|
  counts = positions_after_n_iterations(robots, iterations)

  # try and find a straight, diagonal line somewhere on the grid
  found = counts.any? do |count|
    position, y = count
    x, y = position
    (0...7).all? { |offset| counts[{x + offset, y + offset}] > 0 }
  end

  if found
    puts "found"
    puts iterations
  end
end
