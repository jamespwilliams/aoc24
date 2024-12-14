record Robot, px : Int32, py : Int32, vx : Int32, vy : Int32

robots = [] of Robot
File.read_lines("input").each do |line|
  px, py, vx, vy = line.scan(/-?\d+/).map { |match| match[0].to_i }

  robots.push(Robot.new(px, py, vx, vy))
end

w, h = 101, 103
iterations = 100

square_counts = Hash(Tuple(Int32, Int32), Int32).new { |h, k| h[k] = 0; h[k] }
robots.each do |robot|
  # final_x = (px + vx * iterations) mod w
  # = ( (px mod w) + ( (vx * iterations) mod w ) ) mod w                                (as (AB) mod C = ((A mod C) * (B mod C)) mod C)
  # = ( (px mod w) + ( ( ( vx mod w ) * ( iterations mod w ) ) mod w ) ) mod w          (as (A + B) mod C = (A mod C + B mod C) mod C)

  final_x = ((robot.px % w) + (((robot.vx % w) * (iterations % w)) % w)) % w
  final_y = ((robot.py % h) + (((robot.vy % h) * (iterations % h)) % h)) % h

  square_counts[{final_x, final_y}] += 1
end

quadrant_counts = [0, 0, 0, 0]
square_counts.each do |position, count|
  next if count == 0
  x, y = position
  if x < w // 2
    if y < h // 2
      quadrant_counts[0] += count
    elsif y > h // 2
      quadrant_counts[1] += count
    end
  elsif x > w // 2
    if y < h // 2
      quadrant_counts[2] += count
    elsif y > h // 2
      quadrant_counts[3] += count
    end
  end
end

puts quadrant_counts.product
