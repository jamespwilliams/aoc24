lines = File.read_lines("input")

record Challenge, target : Int64, numbers : Array(Int64)

enum Operation
  Add
  Multiply
end

def parse_challenge(line : String) : Challenge
  target, nums = line.split(": ")

  Challenge.new(target.to_i64, nums.split(" ").map(&.to_i64))
end

def evaluate_challenge(challenge : Challenge, operations : Array(Operation)) : Bool
  acc = challenge.numbers[0]
  operations.each_with_index do |operation, index|
    next_num = challenge.numbers[index + 1]
    case operation
    when Operation::Add
      acc += next_num
    when Operation::Multiply
      acc *= next_num
    end
  end
  return acc == challenge.target
end

def possible_operations(size : Int32) : Array(Array(Operation))
  Indexable.cartesian_product([[Operation::Add, Operation::Multiply]] * size)
end

challenges = lines.map { |l| parse_challenge(l) }

pp challenges.select { |challenge|
  possible_operations(challenge.numbers.size - 1).any? { |operations|
    evaluate_challenge(challenge, operations)
  }
}.map(&.target).sum
