frequency_changes = File.readlines('frequency_changes.txt').map(&:to_i)
initial_frequency = 0
final_frequency   = initial_frequency + frequency_changes.sum

puts final_frequency  # => 402  <--- THE CORRECT ANSWER

