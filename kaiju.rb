require 'set'
require 'digest'

moves = File.read('./monster_moves.txt').split('')

# puts moves.inspect

def triplet_collector(list)
  collector = []
  (list.length - 2).times do |i|
    collector << yield(list[i], list[i+1], list[i+2])
  end
  collector
end


i = 0
mechMoves = []
while (i <= (moves.length - 2))
  a, b, c = moves[i], moves[i+1], moves[i+2]
  set = Set.new([a, b, c])
  if set === "L" && set === "R" && set === "B"
    mechMoves << 'C'
    i += 3
  else
    mechMoves << {'L' => 'H', 'R' => 'S', 'B' => 'K'}[a]
    i += 1
  end
end

# puts mechMoves.inspect

puts Digest::MD5.hexdigest mechMoves.join