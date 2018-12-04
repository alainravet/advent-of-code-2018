require_relative 'guard_sleep_recorder'
require_relative 'guard_event_line_processor'

OBSERVATIONS_EVENTS = [
  '[1518-02-12 23:50] Guard #1789 begins shift', # guard 1
  '[1518-02-13 00:05] falls asleep',
  '[1518-02-13 00:10] wakes up', # slept 5 minutes (05..09)
  '[1518-02-13 00:12] falls asleep',
  '[1518-02-13 00:13] wakes up', # slept 1 more minute (12)

  '[1518-02-14 00:01] Guard #2617 begins shift', # guard 2
  '[1518-02-14 00:24] falls asleep', # slept 7 minutes (22..28)
  '[1518-02-14 00:29] wakes up',

  '[1518-02-14 23:50] Guard #1789 begins shift', # guard 1 again
  '[1518-02-15 00:07] falls asleep',
  '[1518-02-15 00:09] wakes up', # slept another 2 minutes (07..08)

  '[1518-02-15 00:01] Guard #2617 begins shift', # guard 2
  '[1518-02-16 00:24] falls asleep', # slept 7 minutes (22..28)
  '[1518-02-16 00:25] wakes up',

  '[1518-02-16 00:01] Guard #2617 begins shift', # guard 2
  '[1518-02-17 00:24] falls asleep', # slept 7 minutes (22..28)
  '[1518-02-17 00:25] wakes up',
]

recorder       = GuardSleep::Recorder.new
line_processor = GuardEvent::LineProcessor.new(recorder)
OBSERVATIONS_EVENTS.each do |s|
  line_processor.process_guard_event_line(s)
end

expected_slept_minutes_counters = {
  1789 => { 5 => 1, 6 => 1, 7 => 2, 8 => 2, 9 => 1, 12 => 1 },
  #        FIRST MAX HERE : ^^^^^^    (with strategy 1)
  2617 => { 24 => 3, 25 => 1, 26 => 1, 27 => 1, 28 => 1}
}

expected_total_slept_minutes = {
  1789 => (1 + 1 + 2 + 2 + 1 + 1), # == 8
  2617 => (3 + 1 + 1 + 1 + 1)      # == 7
}

recorder.guard_sleep_grid(1789).tap do |grid|
  raise grid.inspect unless grid.total_slept_minutes == expected_total_slept_minutes[1789]
  raise grid.inspect unless grid.slept_minutes_counters == expected_slept_minutes_counters[1789]
end

recorder.guard_sleep_grid(2617).tap do |grid|
  raise grid.inspect unless grid.total_slept_minutes == expected_total_slept_minutes[2617]
  raise grid.inspect unless grid.slept_minutes_counters == expected_slept_minutes_counters[2617]
end

recorder.longest_sleep_details.tap do |details|
  raise details.inspect unless details.guard_id               == 1789 # <- answer part a (guard_id)
  raise details.inspect unless details.minute_with_most_sleep == 7    # <- answer part b (minute_with_most_sleep)
  raise details.inspect unless details.total_slept_minutes    == 8
end
puts "\n*** SUCCESS: test day 4 part 1"
