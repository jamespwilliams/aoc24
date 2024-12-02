lines = File.read_lines("input")

def diff_in_allowed_range(diff : Int32)
  1 <= diff.abs <= 3
end

def is_safe(report : Array(Int32)) : Bool
  diffs = (1..report.size - 1).map { |idx|
    report[idx] - report[idx - 1]
  }

  return false unless diffs.all?(&.positive?) || diffs.all?(&.negative?)

  return diffs.all? { |diff| diff_in_allowed_range(diff) }
end

def is_kinda_safe(report : Array(Int32)) : Bool
  (0..report.size - 1).map { |idx|
    is_safe(report[...idx] + report[idx + 1..])
  }.any?
end

reports = lines.map { |l| l.split.map(&.to_i) }
puts reports.count { |report| is_kinda_safe(report) }
