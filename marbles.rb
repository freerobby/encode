switches = File.read('./switch_defs.txt').split("\n").map { |switch| switch.split(' ') }

NUMTIMES = 1_000_000


def compString(comp)
  comp.values.reduce('') { |str, switch| str += switch[:value] }
end

puts switches.inspect

comp = {}

switches.each do |switch|
  comp[switch[0].to_sym] = {
    value: switch[1],
    left: switch[2].to_sym,
    right: switch[3].to_sym,
  }
end

puts comp.inspect

# puts comp.values.select { |switch| switch[:value] == 'L' }.length

NUMTIMES.times do |_|
  keepGoing = true
  nextSwitch = '1'.to_sym
  while keepGoing
    switch = comp[nextSwitch]
    # puts "index: #{nextSwitch} switch: #{switch}"

    if comp[nextSwitch][:value] == 'L'
      comp[nextSwitch][:value] = 'R'
      nextSwitch = comp[nextSwitch][:left]
    elsif comp[nextSwitch][:value] == 'R'
      comp[nextSwitch][:value] = 'L'
      nextSwitch = comp[nextSwitch][:right]
    end

    keepGoing = false if (nextSwitch == '0'.to_sym)
    puts "FUCK" and raise StandardError.new("FUCK") if nextSwitch == 1
  end
  puts "#{_ / NUMTIMES.to_f * 100}% done"
  # puts compString(comp)
  # puts comp.inspect
end

puts compString(comp)

puts comp.values.select { |switch| switch[:value] == 'L' }.length