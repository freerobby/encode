numbers = File.read('./bus_numbers.txt').split(' ').map(&:to_i).sort

# puts numbers

partitioned = numbers.each_with_index.reduce([]) do |coll, pair|
  element, index = pair

  if index == 0
    [[element]]
  elsif element-1 == numbers[index-1]
    puts "WEWLAD"
    coll[-1] << element
    coll
  else
    coll << [element]
    coll
  end
end


final = partitioned.reduce([]) do |coll, partitioned_member|
  if partitioned_member.length < 3
    partitioned_member.each do |p|
      coll << p
    end
  else
    coll << "#{partitioned_member[0]}-#{partitioned_member[-1]}"
  end
  coll
end

puts final
puts final.length
