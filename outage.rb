timestamps = File.read('./request_times.txt').split(' ').map(&:to_i)
# timestamps = [1000, 1001, 1002, 1999, 2000, 2001]

histogram = [0] * (timestamps[-1] + 1000)

puts histogram.length

timestamps.each do |timestamp|
  (timestamp...(timestamp+1000)).to_a.each do |millisecond|
    histogram[millisecond] = histogram[millisecond] + 1
  end
end

puts histogram.inspect

puts histogram.max / 3.0