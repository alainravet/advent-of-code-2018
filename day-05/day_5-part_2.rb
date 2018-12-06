require_relative 'polymer_reactor'
started_at = Time.now

formula = File.read('formula.txt').chomp.freeze
unit_type, collapsed_length = Polymer::Reactor.new.find_unit_type_to_remove_for_maximum_collapse(formula)

puts "day 5 - part 2: smallest size after removing unit type '%s': %s" % [unit_type, collapsed_length]
# => "day 5 - part 2: smallest size after removing unit type 'm': 6942"           <-- ANSWER PART 2

puts Time.now - started_at # => 0.326997
# 7.881639

