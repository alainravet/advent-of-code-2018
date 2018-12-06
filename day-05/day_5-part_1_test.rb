require_relative 'polymer_reactor'
require_relative '../test_helper'

before         = 'dabAcCaCBAcCcaDA'
expected_after = 'dabCBAcaDA'
assert_equal expected_after,
             Polymer::Reactor.new(before).reactize


before         = 'abcCBAZ'
expected_after = 'Z'
assert_equal expected_after,
             Polymer::Reactor.new(before).reactize

before         = 'abcCBA'
expected_after = ''
assert_equal expected_after,
             Polymer::Reactor.new(before).reactize

puts "\n*** SUCCESS: test day 5 part 1"
