module GuardSleep
  class Grid
    attr_reader :guard_id, :slept_minutes_counters, :total_slept_minutes

    def initialize(guard_id)
      @guard_id = guard_id

      @slept_minutes_counters = Hash.new(0)
      @total_slept_minutes    = 0
    end

    def increment_slept_minutes_counter(slept_minute)
      @slept_minutes_counters[slept_minute] += 1
      @total_slept_minutes                  += 1
    end

    def most_slept_minute_and_sleep_length
      longest_sleep_length  = slept_minutes_counters.values.max
      most_slept_minute, sleep_length = slept_minutes_counters.detect { |_slept_minute, sleep_length|
        sleep_length == longest_sleep_length
      }
      [most_slept_minute, sleep_length]
    end

    def minute_with_most_sleep
      most_slept_minute_and_sleep_length.first
    end

    def longest_single_minute_sleep
      most_slept_minute_and_sleep_length.last
    end
  end
end
