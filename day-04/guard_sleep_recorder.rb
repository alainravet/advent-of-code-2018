require_relative 'guard_sleep_grid'

module GuardSleep
  class Recorder
    def initialize
      @guards_sleep_grids = {}
    end

    def longest_sleep_details
      grid = first_grid_with_longuest_sleep
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

      def first_grid_with_longuest_sleep
        @guards_sleep_grids.values.detect { |grid| grid.total_slept_minutes == longest_sleep_in_minutes }
      end

      def longest_sleep_in_minutes
        @guards_sleep_grids.values.map(&:total_slept_minutes).sort.last
      end
  end
end
