require 'rubygems'
require 'bundler/setup'
Bundler.setup :default

require 'rgl/adjacency'

flights = {}
origins = []
destinations = []

puts "Parsing file"
File.readlines("daily_flights_sample.txt").each_with_index do |line, idx|
  flight_no = idx + 1
  line.chomp!
  i = line.index(" ")
  origin = line[0..(i-1)]
  destination = line[(i+1)..(line.length)]
  puts "Flight #{flight_no}: |#{origin}| ==> |#{destination}|"
  flights[origin] ||= []
  flights[origin] << destination
  origins << origin unless origins.include?(origin)
  destinations << destination unless destinations.include?(destination)
end

puts "Adding edges"
dg=RGL::DirectedAdjacencyGraph.new #[1,2 ,2,3 ,2,4, 4,5, 6,4, 1,6]
flights.each do |k,v|
  v.each do |dest|
    dg.add_edge k, dest
  end
end
puts

puts "Cycles:"
cycles = dg.cycles
cycles.each do |c|
  puts c
  puts
end
puts

puts "Writing graphic"
require 'rgl/dot'
dg.write_to_graphic_file('jpg')
#
# puts "Flights:"
# puts flights
# puts
# puts "Origins:"
# puts origins
# puts
# puts "Destinations:"
# puts destinations
# puts
#
# # Any destination without an origin is bad.
#
# all_airports = origins + destinations
# safe_airports = (all_airports - (destinations - origins)).uniq
#
# puts "Safe airports:"
# puts safe_airports
