require_relative 'polymer_reactor'
require_relative '../test_helper'

FORMULA_TO_COLLAPSE = 'dabAcCaCBAcCcaDA'

# intermediary results:
assert_equal 'dbCBcD',   Polymer::Reactor.new.remove_unit_type_and_collapse_elements(FORMULA_TO_COLLAPSE, 'a').join
assert_equal 'daCAcaDA', Polymer::Reactor.new.remove_unit_type_and_collapse_elements(FORMULA_TO_COLLAPSE, 'b').join
assert_equal 'daDA',     Polymer::Reactor.new.remove_unit_type_and_collapse_elements(FORMULA_TO_COLLAPSE, 'C').join
assert_equal 'abCBAc',   Polymer::Reactor.new.remove_unit_type_and_collapse_elements(FORMULA_TO_COLLAPSE, 'D').join

# PART 2 :
unit_type, collapsed_length = Polymer::Reactor.new.find_unit_type_to_remove_for_maximum_collapse(FORMULA_TO_COLLAPSE)
assert_equal ['c', 4], [unit_type, collapsed_length]

puts "\n*** SUCCESS: test day 5 part 2"
