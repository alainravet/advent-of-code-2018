require_relative 'words_with_letters_repetition_finder'

BOXES_IDS = File.readlines('boxes-ids.txt').map(&:chomp).freeze

twos_counter, threes_counter = 0, 0

BOXES_IDS.each do|box_id|
  multiples = find_characters_repetitions(box_id)
  twos_counter   += 1 if multiples.include?(2)
  threes_counter += 1 if multiples.include?(3)
end

puts [twos_counter, threes_counter].inspect     # => [246, 21]
puts [twos_counter, threes_counter].reduce(&:*) # => 5166     <--- THE ANSWER
