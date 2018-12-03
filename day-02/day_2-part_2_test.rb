require_relative 'words_with_letters_repetition_finder'

cl = nil
raise cl.inspect unless (cl = common_letters_when_only_1_character_differs('fghij', 'fguij')) == %w(f g i j)
raise cl.inspect unless (cl = common_letters_when_only_1_character_differs('abcde', 'axcye')) == nil


input = %w(abcde fghij klmno pqrst fguij axcye wvxyz)
cl    = detect_common_letters_in_pair_of_words_with_only_1_difference(input)
raise cl.inspect unless cl == 'fgij'
