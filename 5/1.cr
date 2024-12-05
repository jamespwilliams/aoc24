lines = File.read_lines("input")

break_index = lines.index!("")

rules = lines[0...break_index]
updates = lines[(break_index + 1)..]

rules = rules.map { |rule| rule.split("|").map(&.to_i) }
updates = updates.map { |update| update.split(",").map(&.to_i) }

updates = updates.select do |update|
  rules.all? do |rule|
    before, after = rule

    before_index = update.index(before)
    after_index = update.index(after)

    before_index == nil || after_index == nil || before_index.not_nil! < after_index.not_nil!
  end
end

puts updates.map { |update|
  update[update.size // 2]
}.sum
