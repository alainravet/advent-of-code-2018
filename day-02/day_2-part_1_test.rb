require_relative 'words_with_letters_repetition_finder'

s = nil
raise s.inspect unless( s = find_characters_repetitions('abcde'))==[1]
raise s.inspect unless( s = find_characters_repetitions('aafaade'))==[4, 1]
raise s.inspect unless( s = find_characters_repetitions('acad'))==[2, 1]
