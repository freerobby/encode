# 176, 175
NUMBERS = [
    [
      "***",
      "* *",
      "* *",
      "* *",
      "***"
    ],
    [
      "  *",
      "  *",
      "  *",
      "  *",
      "  *"
    ],
    [
      "***",
      "  *",
      "***",
      "*  ",
      "***"
    ],
    [
      "***",
      "  *",
      "***",
      "  *",
      "***"
    ],
    [
      "* *",
      "* *",
      "***",
      "  *",
      "  *"
    ],
    [
      "***",
      "*  ",
      "***",
      "  *",
      "***"
    ],
    [
      "***",
      "*  ",
      "***",
      "* *",
      "***"
    ],
    [
      "***",
      "  *",
      "  *",
      "  *",
      "  *"
    ],
    [
      "***",
      "* *",
      "***",
      "* *",
      "***"
    ],
    [
      "***",
      "* *",
      "***",
      "  *",
      "***"
    ]
  ]

data = []
File.readlines("safe_codes.txt").each do |line|
  data << line
end
puts "Found #{data.count} lines in file."

# longest = 0
# data.each do |l|
#   longest = l.length if l.length > longest
# end
# puts "Longest line is #{longest} chars."
# puts "Padding to #{longest} chars."
# new_data = []
# data.each do |l|
#   new_data << l
#   puts new_data[-1].length
#   while new_data[-1].length < longest
#     new_data[-1] += " "
#     puts new_data[-1].length
#   end
# end
# data = new_data

blocks = []
current_block = []
data.each_with_index do |line, line_number|
  current_block << line

  if (line_number + 1) % 6 == 0
    blocks << current_block[0..4]
    current_block = []
  end
end

#blocks << current_block[0..4]

puts "Found #{blocks.count} blocks."
puts "Block 1:"
puts blocks[0]
puts "Block 2:"
puts blocks[1]
puts "Block 3:"
puts blocks[2]
puts "Block 4:"
puts blocks[3]
puts "Block 5:"
puts blocks[4]
puts "Last block:"
puts blocks[-1]

def block_to_digits(lines)
  digits = ""
  20.times do |t|
    this_data = []
    lines.each do |line|
      this_data << line[(t*4 + 0)..(t*4 + 2)]
    end
    # puts ""
    # puts this_data
    # puts ""
    digits += text_to_digit(this_data)
  end
  # puts digits
  digits
end

def text_to_digit(lines)
  NUMBERS.index(lines).to_s
end

strings = []
blocks.each do |b|
  strings << block_to_digits(b)
end

puts "Found #{strings.count} strings:"
puts strings
strings.keep_if{|s| s.length == 20}
puts

puts "#{strings.count} of them are 20-digit valid:"
puts strings
puts

def is_divisible_by_2?(string)
  return false if ["1", "3", "5", "7", "9"].include?(string[-1])
  true
end

strings.keep_if{|s| is_divisible_by_2?(s)}
puts "#{strings.count} are divisible by 2:"
puts strings
puts

def is_divisible_by_3?(string)
  if char_sum(string) % 3 == 0
    return true
  else
    return false
  end
end

def char_sum(string)
  sum = 0
  string.each_char do |c|
    sum += (c.ord - 48)
  end
  sum
end

strings.keep_if{|s| is_divisible_by_3?(s)}
puts "#{strings.count} are divisible by 3:"
strings.each do |s|
  puts "#{s} (digit sum: #{char_sum(s)})"
end