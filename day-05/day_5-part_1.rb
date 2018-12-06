require_relative 'polymer_reactor'
started_at = Time.now

formula           = File.read('formula.txt').chomp
reactized_formula = Polymer::Reactor.new.collapse(formula)

puts "day 5 - part 1: formula size after reaction: %s" % reactized_formula.length
# => "day 5 - part 1: formula size after reaction: 9704"

puts Time.now - started_at # => 0.326997
