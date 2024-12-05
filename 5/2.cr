lines = File.read_lines("input")

break_index = lines.index!("")

rules = lines[0...break_index]
updates = lines[(break_index + 1)..]

rules = rules.map { |rule| rule.split("|").map(&.to_i) }
updates = updates.map { |update| update.split(",").map(&.to_i) }

def find_broken_rule(update : Array(Int32), rules : Array(Array(Int32))) : Array(Int32) | Nil
  return rules.find do |rule|
    before, after = rule

    before_index = update.index(before)
    after_index = update.index(after)

    before_index != nil && after_index != nil && before_index.not_nil! >= after_index.not_nil!
  end
end

updates = updates.select { |update| !find_broken_rule(update, rules).nil? }

def swap(arr : Array(Int32), a : Int32, b : Int32)
  tmp = arr[a]
  arr[a] = arr[b]
  arr[b] = tmp
end

updates.each { |update|
  rule = find_broken_rule(update, rules)
  while !rule.nil?
    before, after = rule
    swap(update, update.index!(before), update.index!(after))

    rule = find_broken_rule(update, rules)
  end
}

puts updates.map { |update|
  update[update.size // 2]
}.sum
