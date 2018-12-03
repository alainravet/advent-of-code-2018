require_relative 'overlap_detector'

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

raise    if od.overlapsed_cells_count != expected_overlaps_count
raise ss if od.grid_to_s              != expected_grid

# PART 2

expected_successful_claims = [3]

raise od.successful_claims.inspect   if od.successful_claims != expected_successful_claims

puts 'tests: SUCCESS at %s' % Time.now
