def common_letters_when_only_1_character_differs(a, b)
  return unless a.length == b.length
  a, b         = a.chars, b.chars
  diff_counter = 0
  diff_idx     = nil
  a.each_with_index do |a_at_idx, idx|
    if a_at_idx != b[idx]
      return if diff_counter == 1   # only 1 different character allowed
      diff_idx     = idx
      diff_counter += 1
    end
  end
  return if diff_counter != 1
  a.delete_at(diff_idx)
  a
end

# tests:
# s = nil
raise s.inspect unless (s = common_letters_when_only_1_character_differs('fghij', 'fguij')) == %w(f g i j)
raise s.inspect unless (s = common_letters_when_only_1_character_differs('abcde', 'axcye')) == nil


def part_2(input)
  max_idx = input.count - 1
  (0..max_idx).each do |a_idx|
    a = input[a_idx]
    (a_idx + 1..max_idx).each do |b_idx|
      b = input[b_idx]
      common_letters = common_letters_when_only_1_character_differs(a, b)
      return common_letters.join  if common_letters
    end
  end
end

# tests:
input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
raise part_2(input).inspect unless part_2(input) ==  'fgij'


INPUT = File.readlines('boxes-ids.txt').map(&:chomp).freeze
puts part_2(INPUT)  # => cypueihajytordkgzxfqplbwn      <--- THE ANSWER
