require_relative 'guard_sleep_grid'

module GuardSleep
  class Recorder
    attr_reader :guards_sleep_grids

    def initialize
      @guards_sleep_grids = {}
    end

    def first_sleep_grid_with_longuest_total_sleep
      max_total = longest_total_sleep_in_minutes
      @guards_sleep_grids.values.detect { |grid| grid.total_slept_minutes == max_total }
    end

    def first_sleep_grid_with_most_slept_minute
      max_total = longest_single_minute_sleep
      res = @guards_sleep_grids.values.detect { |grid|
        minute, length = grid.most_slept_minute_and_sleep_length
        length == max_total
      }
      res
    end


    def guard_sleep_grid(guard_id)
      @guards_sleep_grids[guard_id] ||= Grid.new(guard_id)
    end

    def record_time_asleep(guard_id, from:, to:)
      guard_sleep_grid = guard_sleep_grid(guard_id)
      (from..to).each do |minute|
        guard_sleep_grid.increment_slept_minutes_counter(minute)
      end
    end

    private

      def longest_total_sleep_in_minutes
        total_slept_minutes = @guards_sleep_grids.values.map(&:total_slept_minutes)
        total_slept_minutes.sort.last
      end

      def longest_single_minute_sleep
        longest_single_minute_sleeps = @guards_sleep_grids.values.map(&:longest_single_minute_sleep)
        longest_single_minute_sleeps.sort.last
      end
  end
end
