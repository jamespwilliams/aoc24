record Machine, ax : Int64, ay : Int64, bx : Int64, by : Int64, prize_x : Int64, prize_y : Int64

machines = [] of Machine
File.read_lines("input").each_slice(4) do |lines|
  a, b, prize = lines

  ax, ay = a.scan(/\d+/)
  bx, by = b.scan(/\d+/)
  prize_x, prize_y = prize.scan(/\d+/)

  machines.push(Machine.new(ax[0].to_i, ay[0].to_i, bx[0].to_i, by[0].to_i, prize_x[0].to_i64 + 10000000000000, prize_y[0].to_i64 + 10000000000000))
end

def machine_cost(machine : Machine) : Int64
  b = (machine.prize_y * machine.ax - machine.prize_x * machine.ay) // (machine.by * machine.ax - machine.bx * machine.ay)
  a = (machine.prize_x - b * machine.bx) // machine.ax

  if {machine.ax * a + machine.bx * b, machine.ay * a + machine.by * b} != {machine.prize_x, machine.prize_y}
    return 0_i64
  end
  a * 3_i64 + b
end

puts machines.map { |machine|
  x = machine_cost(machine)
}.compact.sum
