starting_frequency = 0
final_frequency = starting_frequency + File.readlines('frequency_changes.txt').map(&:to_i).sum
puts final_frequency  # => 402
