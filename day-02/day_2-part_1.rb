def find_multiples(text)
  Hash.new(0).tap do |char_counters|
    text.chars.each do |c|
      char_counters[c] += 1
    end
  end.values.uniq
end

# tests:
# s = nil
# raise s.inspect unless( s = find_multiples('abcde'))==[1]
# raise s.inspect unless( s = find_multiples('aafaade'))==[4, 1]
# raise s.inspect unless( s = find_multiples('acad'))==[2, 1]

INPUT = File.readlines('boxes-ids.txt').map(&:chomp).freeze

twos, threes = 0, 0
INPUT.each do|box_id|
  multiples = find_multiples(box_id)
  twos   += 1 if multiples.include?(2)
  threes += 1 if multiples.include?(3)
end

puts [twos, threes].inspect     # => [246, 21]
puts [twos, threes].reduce(&:*) # => 5166     <--- THE ANSWER
