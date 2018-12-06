require_relative 'words_with_letters_repetition_finder'
require_relative '../test_helper'

assert_equal [1],
             find_characters_repetitions('abcde')
assert_equal [4, 1],
             find_characters_repetitions('aafaade')
assert_equal [2, 1],
             find_characters_repetitions('acad')

puts "\n*** SUCCESS: test day 2 - part 1"
