require_relative 'overlap_detector'

claims = [
  '#1 @ 1,3: 4x4',
  '#2 @ 3,1: 4x4',
  '#3 @ 5,5: 2x2',
]

expected_grid = "
.......
...1111
...1111
.22XX11
.22XX11
.222233
.222233".strip

expected_overlaps_count = 4

od = OverlapDetector.new
od.encode_claims(claims)

raise    if od.overlaps_count != expected_overlaps_count
raise ss if od.grid_to_s      != expected_grid

puts 'tests: SUCCESS at %s' % Time.now

