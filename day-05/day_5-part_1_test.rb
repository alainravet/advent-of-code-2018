require_relative 'polymer_reactor'
require_relative '../test_helper'

before         = 'dabAcCaCBAcCcaDA'
expected_after = 'dabCBAcaDA'
assert_equal expected_after,
             Polymer::Reactor.new.collapse(before)


before         = 'abcCBAZ'
expected_after = 'Z'
assert_equal expected_after,
             Polymer::Reactor.new.collapse(before)

before         = 'abcCBA'
expected_after = ''
assert_equal expected_after,
             Polymer::Reactor.new.collapse(before)

puts "\n*** SUCCESS: test day 5 part 1"
