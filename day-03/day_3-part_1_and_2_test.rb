require_relative 'overlap_detector'
require_relative '../test_helper'

claims = [
  '#1 @ 1,3: 4x4',
  '#2 @ 3,1: 4x4',
  '#3 @ 5,5: 2x2',
]

od = OverlapDetector.new
od.encode_claims(claims)

# PART 1

expected_overlaps_count = 4
expected_grid = "
.......
...1111
...1111
.22XX11
.22XX11
.222233
.222233".strip

assert_equal expected_overlaps_count,
             od.overlapsed_cells_count
assert_equal expected_grid,
             od.grid_to_s

# PART 2

expected_successful_claims = [3]

assert_equal expected_successful_claims,
             od.successful_claims

puts "\n*** SUCCESS: test day 3"
