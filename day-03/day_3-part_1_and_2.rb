require_relative 'overlap_detector'

claims = File.readlines('claims.txt').map(&:chomp).freeze
od = OverlapDetector.new
od.encode_claims(claims)

# PART 1
puts od.overlapsed_cells_count  # => 103806  <-- THE CORRECT ANSWER

# PART 2
puts od.successful_claims       # 625 <-- THE CORRECT ANSWER

puts od.encoding_time   # => 0.137771
