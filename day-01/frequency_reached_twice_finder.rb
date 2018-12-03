class FrequencyReachedTwiceFinder
  def initialize(frequency_changes, initial_frequency: 0)
    @frequency_changes = frequency_changes

    @current_frequency   = initial_frequency
    @reached_frequencies = {
      initial_frequency => true
    }
  end

  def find_frequency
    frequency_reached_twice = apply_frequency_changes until frequency_reached_twice
    frequency_reached_twice
  end

  private

    def apply_frequency_changes
      @frequency_changes.each do |frequency_change|
        new_frequency = apply_frequency_change(frequency_change)
        if frequency_was_previously_reached?(new_frequency)
          return new_frequency
        else
          remember_frequency_was_reached(new_frequency)
        end
      end
      nil
    end

    def apply_frequency_change(frequency_change)
      @current_frequency += frequency_change
    end

    def remember_frequency_was_reached(frequency)
      @reached_frequencies[frequency] = true
    end

    def frequency_was_previously_reached?(frequency)
      @reached_frequencies.has_key?(frequency)
    end
end
