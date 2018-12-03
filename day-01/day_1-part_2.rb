require_relative 'frequency_reached_twice_finder'

frequency_changes = File.readlines('frequency_changes.txt').map(&:to_i)

puts FrequencyReachedTwiceFinder.new(frequency_changes).find_frequency # => 481
