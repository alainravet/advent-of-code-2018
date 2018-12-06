require_relative 'words_with_letters_repetition_finder'
require_relative '../test_helper'

input = %w(fghij fguij)
assert_equal %w(f g i j),
             common_letters_when_only_1_character_differs(*input)

input = %w(abcde axcye)
assert_equal nil,
             common_letters_when_only_1_character_differs(*input)

input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
assert_equal 'fgij',
             detect_common_letters_in_pair_of_words_with_only_1_difference(input)

puts "\n*** SUCCESS: test day 2 - part 2"
