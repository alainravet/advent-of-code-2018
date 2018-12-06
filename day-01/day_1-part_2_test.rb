require_relative 'frequency_reached_twice_finder'
require_relative '../test_helper'

#                           pass #1  pass #2
#          START HERE -------> 0      -> 3
frequency_changes = [+1, #    1        4
                     -2, #   -1       <2>
                     +3, #   <2>
                     -4, #   -2
                     +5] #    3 ->

expected_frequency = 2
found_frequencey   = FrequencyReachedTwiceFinder.new(frequency_changes, initial_frequency: 0).find_frequency
assert_equal expected_frequency, found_frequencey

puts "\n*** SUCCESS: test day 1"
