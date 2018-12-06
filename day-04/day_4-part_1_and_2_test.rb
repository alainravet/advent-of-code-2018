require_relative 'guard_sleep_recorder'
require_relative 'guard_event_line_processor'
require_relative '../test_helper'

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

# test intermediary data:

expected_slept_minutes_counters = {
  1789 => { 5 => 1, 6 => 1, 7 => 2, 8 => 2, 9 => 1, 12 => 1 },
  #                         ^^^^^^ <------------------- WINNER for strategy 1)
  2617 => { 24 => 3, 25 => 1, 26 => 1, 27 => 1, 28 => 1 }
  #         ^^^^^^ <----------------------------------- WINNER for strategy 2)
}
assert_equal expected_slept_minutes_counters[1789],
             recorder.guard_sleep_grid(1789).slept_minutes_counters

assert_equal expected_slept_minutes_counters[2617],
             recorder.guard_sleep_grid(2617).slept_minutes_counters

# PART 1: (strategy 1)

recorder.first_sleep_grid_with_longuest_total_sleep.tap do |winner|
  assert_equal 1789, winner.guard_id                # <- answer 1 part a (guard_id)
  assert_equal 7,    winner.minute_with_most_sleep  # <- answer 1 part b (minute_with_most_sleep)
end

puts "\n*** SUCCESS: test day 4 part 1"

# PART 2: (strategy 2)

recorder.first_sleep_grid_with_most_slept_minute.tap do |winner|
  assert_equal 2617, winner.guard_id                 # <- answer 2 part a (guard_id)
  assert_equal 24, winner.minute_with_most_sleep     # <- answer 2 part b (minute_with_most_sleep)
end

puts "\n*** SUCCESS: test day 4 part 2"
