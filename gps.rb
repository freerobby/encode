def euclideanDistance(start, finish)
  ((finish[1] - start[1])**2 + (finish[2] - start[2])**2)**0.5
end


lines = File.read('./run_positions.txt').split("\n").map { |a| a.split(' ').map(&:to_i) }
# lines = [[0,0,0], [4,2,1], [5,4,3], [6,1,6], [8,-2,4], [9,-4,5], [14, -5, 4], [15, -3, 7], [23, 0, 6]]

puts lines.inspect

actualData = []
lines.each_cons(2) do |lines|
  line1, line2 = lines

  time1, x1, y1 = line1
  time2, x2, y2 = line2

  xrate = (x2 - x1) / (time2 - time1).to_f
  yrate = (y2 - y1) / (time2 - time1).to_f

  puts "#" * 60
  puts "line1:\n\t#{line1}\nline2:\n\t#{line2}\nxrate:\n\t#{xrate}\nyrate:\n\t#{yrate}"
  puts "#" * 60

  (time1...time2).to_a.each do |time|
    puts "#{[time, (time - time1) * xrate + x1, (time - time1) * yrate + y1]}"
    actualData << [time, (time - time1) * xrate + x1, (time - time1) * yrate + y1]
  end
  puts "#" * 60
end

actualData << lines.last

recordedData = actualData.select { |d| d[0].even? }

recordedData << actualData[-1] if (recordedData[-1][0] != actualData[-1][0])

puts "actual data: #{actualData}"
puts "recorded data: #{recordedData.inspect}"

actualDistance = actualData.each_cons(2).reduce(0) do |distance, lines|
  distance += euclideanDistance(lines[0],lines[1])
  distance
end

recordedDistance = recordedData.each_cons(2).reduce(0) do |distance, lines|
  distance += euclideanDistance(lines[0],lines[1])
  distance
end

puts "actual distance: #{actualDistance}, recordedDistance: #{recordedDistance}, loss: #{actualDistance - recordedDistance}"

puts actualDistance - recordedDistance