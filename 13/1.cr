record Machine, ax : Int32, ay : Int32, bx : Int32, by : Int32, prize_x : Int32, prize_y : Int32

machines = [] of Machine
File.read_lines("input").each_slice(4) do |lines|
  a, b, prize = lines

  ax, ay = a.scan(/\d+/)
  bx, by = b.scan(/\d+/)
  prize_x, prize_y = prize.scan(/\d+/)

  machines.push(Machine.new(ax[0].to_i, ay[0].to_i, bx[0].to_i, by[0].to_i, prize_x[0].to_i, prize_y[0].to_i))
end

def machine_cost(machine : Machine) : Int32 | Nil
  lowest_cost = nil

  (0..100).each do |a|
    (0..100).each do |b|
      next unless ((a * machine.ax + b * machine.bx) == machine.prize_x) && ((a * machine.ay + b * machine.by) == machine.prize_y)

      cost = a * 3 + b * 1
      lowest_cost = lowest_cost.nil? ? cost : Math.min(lowest_cost, cost)
    end
  end

  return lowest_cost
end

puts machines.map { |machine|
  machine_cost(machine)
}.compact.sum
