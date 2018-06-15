roads = []

puts "Parsing file"
File.readlines("road_defs.txt").each_with_index do |line, idx|
  line.chomp!
  roads << line.split(" ").map{|r| r.to_i}
end

p roads

cities = roads.flatten.uniq

p cities
puts

city_counts = {}
roads.each do |r|
  if city_counts.has_key?(r[0])
    city_counts[r[0]] += 1
  else
    city_counts[r[0]] = 1
  end
  if city_counts.has_key?(r[1])
    city_counts[r[1]] += 1
  else
    city_counts[r[1]] = 1
  end
end

def get_roads_by_city(city, roads)
  these_roads = roads.select{|r| r[0] == city}
  if these_roads.nil?
    these_roads roads.select{|r| r[1] == city}
  end
  these_roads
end

def get_road_by_city(city, roads)
  get_roads_by_city(city, roads)[0]
end

unsolved_roads = roads.dup
solved_roads = []

def solve_single_city_roads!(city_counts, unsolved_roads, solved_roads)
  city_counts.each do |city, count|
    if count == 1
      road = get_road_by_city(city, unsolved_roads)
      next if road.nil?
      if road[0] == city
        solved_roads << [city, road[1]]
      else
        solved_roads << [city, road[0]]
      end
      city_counts[road[0]] -= 1
      city_counts[road[1]] -= 1
      unsolved_roads.delete(road)
    end
  end
end

def solve_double_roads!(city_counts, unsolved_roads, solved_roads)
  unsolved_roads.each_with_index do |road1, i1|
    unsolved_roads.each_with_index do |road2, i2|
      next if i1 == i2
      smaller_city1 = [road1[0], road1[1]].min
      bigger_city1 = [road1[0], road1[1]].max
      smaller_city2 = [road2[0], road2[1]].min
      bigger_city2 = [road2[0], road2[1]].max

      if smaller_city1 == smaller_city2 && bigger_city1 == bigger_city2
        solved_roads << [smaller_city1, bigger_city1]
        solved_roads << [bigger_city2, smaller_city2]
        unsolved_roads.delete([smaller_city1, bigger_city1])
        unsolved_roads.delete([bigger_city2, smaller_city2])
        city_counts[smaller_city1] -= 2
        city_counts[bigger_city2] -= 2
      end
    end
  end
end
p city_counts


puts "Solving single city roads..."
solve_single_city_roads!(city_counts, unsolved_roads, solved_roads)

p unsolved_roads
p city_counts
p solved_roads
puts

puts "Solving double roads..."
solve_double_roads!(city_counts, unsolved_roads, solved_roads)

p unsolved_roads
p city_counts
p solved_roads
puts

puts "Solving more roads..."
solve_single_city_roads!(city_counts, unsolved_roads, solved_roads)
solve_double_roads!(city_counts, unsolved_roads, solved_roads)
solve_single_city_roads!(city_counts, unsolved_roads, solved_roads)
solve_double_roads!(city_counts, unsolved_roads, solved_roads)

p unsolved_roads
p city_counts
p solved_roads
puts

solved_roads.sort!{|a,b| a[0] <=> b[0]}

p solved_roads
data = solved_roads.map{|sr| sr[1]}.join(",")
p data

require 'digest'
p Digest::MD5.hexdigest data