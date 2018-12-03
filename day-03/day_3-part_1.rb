require_relative 'overlap_detector'

claims = File.readlines('claims.txt').map(&:chomp).freeze
od = OverlapDetector.new
od.encode_claims(claims)

puts od.overlaps_count  # => 103806  <-- THE CORRECT ANSWER
puts od.encoding_time   # => 0.137771
