board = File.read('./delivery_map (1).txt').split("\n").map { |a| a.split(' ').map(&:to_i) }

puts board.inspect

height = board.length
width = board.first.length

allPossibleLocations = (0...width).to_a.product((0...height).to_a)


puts allPossibleLocations.inspect

def manhattanDistance(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

kitchenCostPairs = allPossibleLocations.map do |kitchenLocation|
  totalCost = allPossibleLocations.reduce(0) do |cost, deliveryLocation|
    x, y = deliveryLocation
    deliveryLocationCost = board[y][x]
    cost += manhattanDistance(kitchenLocation, deliveryLocation) * deliveryLocationCost
    cost # meh
  end
  [kitchenLocation, totalCost]
end

sortedKitchenCostPairs = kitchenCostPairs.sort do |a, b|
  a[1] <=> b[1]
end

puts sortedKitchenCostPairs.inspect
puts ""
puts sortedKitchenCostPairs.first.inspect