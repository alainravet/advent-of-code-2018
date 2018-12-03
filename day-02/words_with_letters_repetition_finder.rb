# PART 1:

def find_characters_repetitions(text)
  characters_counters = Hash.new(0)
  text.chars.each do |char|
    characters_counters[char] += 1
  end
  repetitions_sizes = characters_counters.values
  repetitions_sizes.uniq
end


# PART 2:

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
