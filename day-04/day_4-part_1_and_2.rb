require_relative 'guard_sleep_recorder'
require_relative 'guard_event_line_processor'
started_at = Time.now

recorder  = GuardSleep::Recorder.new
processor = GuardEvent::LineProcessor.new(recorder)

File.readlines('guards-events.txt').map(&:chomp).sort.each do |guard_event_line|
  processor.process_guard_event_line(guard_event_line)
end

recorder.first_sleep_grid_with_longuest_total_sleep.tap do |winner|
  guard_id  = winner.guard_id
  minute    = winner.minute_with_most_sleep
  puts "strategy 1: guard %s * minute %s = %s" % [guard_id, minute, guard_id * minute]
  # => "strategy 1: guard 3041 * minute 39 = 118599"
end

recorder.first_sleep_grid_with_most_slept_minute.tap do |winner|
  guard_id  = winner.guard_id
  minute    = winner.minute_with_most_sleep
  puts "strategy 2: guard %s * minute %s = %s" % [guard_id, minute, guard_id * minute]
  # => "strategy 2: guard 1997 * minute 17 = 33949"
end
puts Time.now - started_at # => 0.008009
