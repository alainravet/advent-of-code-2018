def common_letters_when_only_1_character_differs(word_a, word_b)
  return unless word_a.length == word_b.length

  word_a_chars, word_b_chars    = word_a.chars, word_b.chars
  chars_diffs_counter = 0
  char_diff_idx     = nil
  word_a_chars.each_with_index do |word_a_char, idx|
    word_b_char      = word_b_chars[idx]
    difference_found = (word_a_char != word_b_char)
    if difference_found
      chars_diffs_counter += 1
      char_diff_idx       = idx
      return if chars_diffs_counter > 1   # FAIL: only 1 different character allowed
    end
  end
  return if chars_diffs_counter != 1
  word_a_chars.delete_at(char_diff_idx)
  word_a_chars # SUCCESS
end

# tests:
# s = nil
raise s.inspect unless (s = common_letters_when_only_1_character_differs('fghij', 'fguij')) == %w(f g i j)
raise s.inspect unless (s = common_letters_when_only_1_character_differs('abcde', 'axcye')) == nil


def detect_common_letters_in_pair_of_words_with_only_1_difference(words)
  max_word_idx = words.count - 1
  (0..max_word_idx).each do |word_a_idx|
    word_a = words[word_a_idx]
    (word_a_idx + 1..max_word_idx).each do |word_b_idx|
      word_b = words[word_b_idx]
      common_letters = common_letters_when_only_1_character_differs(word_a, word_b)
      return common_letters.join  if common_letters
    end
  end
end

# tests:
input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
cl    = detect_common_letters_in_pair_of_words_with_only_1_difference(input)
raise cl.inspect unless cl == 'fgij'


INPUT = File.readlines('boxes-ids.txt').map(&:chomp).freeze
puts detect_common_letters_in_pair_of_words_with_only_1_difference(INPUT)  # => cypueihajytordkgzxfqplbwn      <--- THE ANSWER
