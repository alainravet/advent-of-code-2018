require_relative 'frequency_reached_twice_finder'

#                           pass #1  pass #2
#          START HERE -------> 0      -> 3
frequency_changes = [+1,  #    1        4
                     -2,  #   -1       <2>
                     +3,  #   <2>
                     -4,  #   -2
                     +5]  #    3 ->

expected_frequency = 2

found_frequency = FrequencyReachedTwiceFinder.new(frequency_changes, initial_frequency: 0).find_frequency
raise found_frequency.inspect unless found_frequency == expected_frequency

puts "tests: SUCCESS at %s" % Time.now
