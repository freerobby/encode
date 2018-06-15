# 914, 704
#
flights = {}
origins = []
destinations = []

puts "Parsing file"
File.readlines("daily_flights.txt").each_with_index do |line, idx|
  flight_no = idx + 1
  line.chomp!
  i = line.index(" ")
  origin = line[0..(i-1)]
  destination = line[(i+1)..(line.length)]
  puts "Flight #{flight_no}: |#{origin}| ==> |#{destination}|"
  flights[origin] ||= []
  flights[origin] << destination
  flights[destination] ||= []
  origins << origin unless origins.include?(origin)
  destinations << destination unless destinations.include?(destination)
end

require 'tsort'

each_node = lambda {|&b| flights.each_key(&b) }
each_child = lambda {|n, &b| flights[n].each(&b)}

# answers = []
# TSort.each_strongly_connected_component(each_node, each_child) {|scc| answers << scc if scc.length > 1 }
answers = TSort.strongly_connected_components(each_node, each_child)
answers.keep_if {|a| a.count > 1}
answer = answers[0]
p answer.count
p answer

def augment_answers(answer, flights)
  flights.each do |origin, destinations|
    destinations.each do |destination|
      if answer.include?(destination)
        answer << origin unless answer.include?(origin)
      end
    end
  end

  return answer
end
#
last_count = 0
while last_count != answer.count do
  last_count = answer.count
  answer = augment_answers(answer, flights)
end

p answer.count
p answer.sort

answer.uniq!

p answer.count
p answer.sort

#
# # Any destination without an origin is bad.
#
# all_airports = origins + destinations
# safe_airports = (all_airports - (destinations - origins)).uniq
#
# puts "Safe airports:"
# puts safe_airports
