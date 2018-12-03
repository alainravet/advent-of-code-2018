require_relative 'words_with_letters_repetition_finder'

words          = File.readlines('boxes-ids.txt').map(&:chomp).freeze
common_letters = detect_common_letters_in_pair_of_words_with_only_1_difference(words)
puts common_letters # => cypueihajytordkgzxfqplbwn      <--- THE ANSWER
