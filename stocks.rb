prices = File.read('./stock_prices.txt').split(' ').map(&:to_i)

# puts prices

def doubleEach(list)
  (list.length - 1).times do |i|
    yield(list[i], list[i+1])
  end
end


stocks = 0
money = 100

doubleEach(prices) do |a, b|
  if (a < b)
    maxPurchase = (100_000 - stocks) * a
    if (maxPurchase < money)
      stocks += maxPurchase / a
      money -= maxPurchase
    else
      stocks += money / a
      money = money % a
    end
  elsif (a > b)
    money += stocks * a
    stocks = 0
  end

  puts "a: $#{a} b: $#{b} :: $#{money}, ##{stocks}"
end

puts money
puts stocks
