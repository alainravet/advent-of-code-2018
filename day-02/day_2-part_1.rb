def find_characters_repetitions(text)
  characters_counters = Hash.new(0)
  text.chars.each do |char|
    characters_counters[char] += 1
  end
  repetitions_sizes = characters_counters.values
  repetitions_sizes.uniq
end

# tests:
s = nil
raise s.inspect unless( s = find_characters_repetitions('abcde'))==[1]
raise s.inspect unless( s = find_characters_repetitions('aafaade'))==[4, 1]
raise s.inspect unless( s = find_characters_repetitions('acad'))==[2, 1]

INPUT = File.readlines('boxes-ids.txt').map(&:chomp).freeze

twos, threes = 0, 0
INPUT.each do|box_id|
  multiples = find_characters_repetitions(box_id)
  twos   += 1 if multiples.include?(2)
  threes += 1 if multiples.include?(3)
end

puts [twos, threes].inspect     # => [246, 21]
puts [twos, threes].reduce(&:*) # => 5166     <--- THE ANSWER
