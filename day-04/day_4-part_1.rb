require_relative 'guard_sleep_recorder'
require_relative 'guard_event_line_processor'
started_at = Time.now

recorder  = GuardSleep::Recorder.new
processor = GuardEvent::LineProcessor.new(recorder)

File.readlines('guards-events.txt').map(&:chomp).sort.each do |guard_event_line|
  processor.process_guard_event_line(guard_event_line)
end

longest_sleep_details  = recorder.longest_sleep_details
guard_id               = longest_sleep_details.guard_id
minute_with_most_sleep = longest_sleep_details.minute_with_most_sleep
part_1_answer          = guard_id * minute_with_most_sleep
puts part_1_answer # => 118599

puts Time.now - started_at # => 0.008009
